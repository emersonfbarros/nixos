{
  flake.modules.nixos.neovim-minimal =
    { pkgs, ... }:
    {
      programs.neovim = {
        enable = true;
        defaultEditor = true;

        configure = {
          packages.myVimPackage = with pkgs.vimPlugins; {
            start = [
              mini-files
              mini-pick
              mini-fuzzy
            ];
          };

          customLuaRC = ''
            vim.g.mapleader = ' '
            vim.g.maplocalleader = ' '

            vim.wo.number = true

            vim.schedule(function()
              vim.opt.clipboard = 'unnamedplus'
            end)

            require('mini.files').setup({ content = { prefix = function() end } })

            local pick = require('mini.pick')
            pick.setup({ source = { show = pick.default_show } })

            local map = vim.keymap.set

            map('n', '<leader>ff', pick.builtin.files, { desc = 'Find Files' })
            map('n', '<leader>fb', pick.builtin.buffers, { desc = 'Find Buffers' })
            map('n', '<leader>fg', pick.builtin.grep_live, { desc = 'Grep Live' })
            map('n', '<leader>fh', pick.builtin.help, { desc = 'Find Help' })

            map('n', '<leader>e', function() require('mini.files').open() end, { desc = 'Mini Files' })

            map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
            map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
            map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
            map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

            map('n', '<Esc>', '<cmd>nohlsearch<CR>')
          '';
        };
      };
    };
}
