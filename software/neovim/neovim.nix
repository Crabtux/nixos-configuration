{ pkgs, ... }:

{
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

        let g:airline_theme='deus'
        let g:airline_powerline_fonts = 1
        let g:airline#extensions#tabline#enabled = 1

        colorscheme tokyonight-night

        lua << EOF
          vim.api.nvim_create_user_command('Shell', 'bel sp | resize 15 | te', {})
        EOF
      '';

      packages.plugins = with pkgs.vimPlugins; {
        start = [
          tokyonight-nvim
          nerdtree
          dashboard-nvim
          vim-nix
          vim-airline
          vim-airline-themes
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
}
