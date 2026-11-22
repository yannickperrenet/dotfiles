#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.12"
# dependencies = [
#     "psutil>=7.2.2",
#     "pydantic>=2.14.4",
# ]
# ///


import psutil
import subprocess
from collections.abc import Sequence
from pathlib import Path
from typing import Annotated, NamedTuple, NewType, Self

from pydantic import BaseModel, ValidationError, Field, TypeAdapter

CLAUDE_DIR = Path.home() / ".claude" / "sessions"

# $WINDOWID of X-server, requested and assigned by alacritty.
# The X protocol guarantees it is a 32-bit unsigned integer.
WindowId = NewType("WindowId", int)
window_id_adapter = TypeAdapter(
    Annotated[WindowId, Field(gt=0, lt=2**29)]
)


class ClaudeSession(BaseModel):
    pid: int
    cwd: str
    entrypoint: str
    name: str
    status: str


class RofiOption(NamedTuple):
    window_id: WindowId
    label: str

    @classmethod
    def from_claude(
        cls,
        session: ClaudeSession,
        window_id: WindowId,
    ) -> Self:
        return cls(
            window_id=window_id,
            label=f"{session.status} | {session.cwd} | {session.entrypoint} | {session.name}",
        )


def pick(options: Sequence[str], prompt: str = "claude") -> int | None:
    """Show options in rofi and return the index of the chosen one.

    Args:
        options: Options to display in rofi. Note, options must not
            contain newlines, since rofi reads one row per line.

    Returns:
        `None` when the user cancels, else the index into `options`
        representing the chosen option.
    """
    result = subprocess.run(
        [
            "rofi",
            # Read rows from stdin and write chosen row to stdout.
            "-dmenu",
            # Filter case insensitive. It filters the rows based on what
            # you type.
            "-i",
            # stops Enter from accepting text that matches no row.
            # Without it, typing something unmatched and pressing Enter
            # returns -1.
            "-no-custom",
            # The text to display on the prompt
            "-p", prompt,
            # Output the index of the row.
            "-format", "i"
        ],
        input="\n".join(options),
        capture_output=True,
        text=True,
        # Do not raise an error on a non-zero exit code.
        check=False,
    )
    # Only on returncode=0 did the user select a row.
    if result.returncode != 0:
        return None
    index = result.stdout.strip()
    return int(index) if index.isdigit() else None


def focus(window_id: WindowId) -> None:
    """Switch to the window's workspace and focus the window."""
    # Do not check the exit code, because the window might've been
    # killed in the meantime and thus the switch would fail.
    subprocess.run(["i3-msg", f"[id={window_id}] focus"], check=False)


def find_claude_sessions() -> list[RofiOption]:
    options: list[RofiOption] = []

    for path in CLAUDE_DIR.iterdir():
        if not path.suffix.endswith("json"):
            continue

        try:
            session = ClaudeSession.model_validate_json(path.read_bytes())
        except ValidationError:
            continue
        except FileNotFoundError:
            # The claude session could've ended in the meantime.
            continue

        # Get the WindowId through /proc/id/environ in a platform
        # agnostic way.
        env = psutil.Process(session.pid).environ()
        # $WINDOWID should be assigned by alacritty, but better be safe
        # then sorry.
        try:
            window_id = window_id_adapter.validate_strings(env.get("WINDOWID"))
        except ValidationError:
            continue

        option = RofiOption.from_claude(
            session=session,
            window_id=window_id,
        )
        options.append(option)

    return options


def main() -> None:
    sessions = find_claude_sessions()
    chosen = pick([session.label for session in sessions])
    if chosen is not None:
        focus(sessions[chosen].window_id)


if __name__ == "__main__":
    main()
