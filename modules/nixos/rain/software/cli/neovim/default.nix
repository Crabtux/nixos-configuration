{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.rain.software.cli.enable {
    # Nix LSP
    environment.systemPackages = with pkgs; [
      nil
    ];

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;

      configure = {
        customRC = ''
          set relativenumber	
          set showbreak=+++ 	
          set showmatch	
          set visualbell	
           
          set hlsearch	
          set smartcase	
          set ignorecase	
          set incsearch	
           
          set autoindent	
          set cindent
          set expandtab
          set shiftwidth=4
          set smartindent	
          set smarttab	
          set softtabstop=4

          set cursorline
           
          set ruler
           
          set undolevels=1000	
          set backspace=indent,eol,start

          set termguicolors

          autocmd VimEnter * NERDTree

          colorscheme rose-pine

          lua << EOF
            vim.api.nvim_create_user_command('Shell', 'bel sp | resize 15 | te', {})

            vim.opt.laststatus = 2 -- Or 3 for global statusline
            vim.opt.statusline = " %f %m %= %l:%c ♥ "
            
            require("rose-pine").setup({
            	highlight_groups = {
            		StatusLine = { fg = "love", bg = "love", blend = 10 },
            		StatusLineNC = { fg = "subtle", bg = "surface" },
            	},
            })

            local cmp = require('cmp')
            cmp.setup {
              mapping = {
                ['<C-p>'] = cmp.mapping.select_prev_item(),
                ['<C-n>'] = cmp.mapping.select_next_item(),
                ['<C-space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.close(),
                ['<tab>'] = cmp.mapping.confirm { select = true },
              },
              sources = cmp.config.sources({
                { name = 'nvim_lsp' },
              }),
            }
            require'lspconfig'.nil_ls.setup{}
          EOF
        '';

        packages.plugins = with pkgs.vimPlugins; {
          start = [
            rose-pine
            nerdtree
            dashboard-nvim
            nvim-web-devicons
            barbar-nvim
            vim-nix
            vim-devicons

            nvim-lspconfig
            cmp-nvim-lsp
            cmp-buffer
            cmp-path
            cmp-cmdline
            nvim-cmp
            ultisnips
            cmp-nvim-ultisnips
          ];

          opt = [ ];
        };
      };
    };
  };
}
