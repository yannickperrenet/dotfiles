local builtin = require('telescope.builtin')

function find_files(opts)
  return function()
               builtin.find_files(opts)
         end
end

function find_dotfiles()
    builtin.find_files {
        prompt_title = "~ dotfiles ~",
        cwd = "$XDG_CONFIG_HOME/nvim",
        hidden = true,
    }
end

function git_files()
    builtin.git_files {
        git_command = {
            "git",
            "ls-files",
            "-c",
            -- Show untracked files in the output as well, useful when
            -- you add a new file which you haven't `git add` yet.
            "-o",
            "--exclude-standard",
        }
    }
end

function live_grep_dotfiles()
    builtin.live_grep {
        prompt_title = "~ Live Grep Dotfiles ~",
        cwd = "$XDG_CONFIG_HOME/nvim",
    }
end

-- Files/Search related
vim.keymap.set('n', '<leader>ff', find_files({hidden=true}), {desc="[F]ind [F]iles"})
vim.keymap.set('n', '<leader>ft', git_files, {desc="[F]ind gi[T] files"})
vim.keymap.set('n', '<leader>fd', find_dotfiles, {desc="[F]ind [D]otfiles"})
vim.keymap.set('n', '<leader>fo', builtin.oldfiles, {desc="[F]ind [O]ldfiles"})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {desc="[F]ind [G]rep"})
vim.keymap.set('n', '<leader>gd', live_grep_dotfiles, {desc="[G]rep [D]otfiles"})
-- Nvim related
vim.keymap.set('n', '<leader>fb', builtin.buffers, {desc="[F]ind [B]uffers"})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {desc="[F]ind [H]elptags"})
vim.keymap.set('n', '<leader>fk', builtin.keymaps, {desc="[F]ind [K]eymaps"})
vim.keymap.set('n', '<leader>fm', builtin.marks, {desc="[F]ind [M]arks"})
vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, {desc="[/] Search but fuzzily"})
-- LSP related
vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, {desc="[F]ind [S]ymbols"})

require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },

    mappings = {
      i = {
        -- Functions that are part of `telescope.actions` can be set
        -- using a string, e.g. `telescope.actions.move_selection_next`
        ["<C-k>"] = "move_selection_previous",
        ["<C-j>"] = "move_selection_next",
        -- TODO: I could make this "cycle through options" like with
        -- ctrlp
        -- ["<C-f>"] = find_files({}),
      }
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}

if pcall(require('telescope').load_extension, 'fzf') then
    do end
else
    -- This extension requires to be built before it can be loaded. Thus
    -- if we can't load it, we build it. Note however that the very
    -- first time that Neovim is opened the extension will not be
    -- loaded as it is has not been built yet.
    os.execute("cd $XDG_CONFIG_HOME/nvim/pack/bundle/opt/telescope-fzf-native.nvim/ && cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build")
end
