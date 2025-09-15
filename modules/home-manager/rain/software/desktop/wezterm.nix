{ pkgs, config, lib, ... }:

{
  config = lib.mkIf config.rain.home.software.desktop.enable {
    # TODO: 更智能一点
    home.sessionVariables.TERMINAL = "wezterm";

    programs.wezterm = {
      enable = true;
      enableBashIntegration = true;

      package = pkgs.unstable.wezterm;

      extraConfig = ''
        local wezterm = require 'wezterm'
        local config = {}

        -- In newer versions of wezterm, use the config_builder which will
        -- help provide clearer error messages
        if wezterm.config_builder then
          config = wezterm.config_builder()
        end

        -- The wezterm's built-in internal rose-pine color_scheme uses wrong
        -- color, so we will override it here.
        -- ref: https://github.com/neapsix/wezterm/blob/main/plugin/init.lua
        local main_palette = {
          base = '#191724',
          overlay = '#26233a',
          muted = '#6e6a86',
          text = '#e0def4',
          love = '#eb6f92',
          gold = '#f6c177',
          rose = '#ebbcba',
          pine = '#31748f',
          foam = '#9ccfd8',
          iris = '#c4a7e7',
          highlight_low = '#21202e',
          highlight_med = '#403d52',
          highlight_high = '#524f67',
        }

        local rose_pine = wezterm.color.get_builtin_schemes()['rose-pine']
        rose_pine.ansi = {
            main_palette.overlay,
            main_palette.love,
            main_palette.pine,
            main_palette.gold,
            main_palette.foam,
            main_palette.iris,
            main_palette.rose,
            main_palette.text,
        }
        rose_pine.brights = {
            main_palette.muted,
            main_palette.love,
            main_palette.pine,
            main_palette.gold,
            main_palette.foam,
            main_palette.iris,
            main_palette.rose,
            main_palette.text,
        }
        rose_pine.selection_bg = main_palette.highlight_med
        rose_pine.selection_fg = 'none'

        config.color_schemes = {
          ['Patched rose-pine'] = rose_pine
        }
        config.color_scheme = 'Patched rose-pine'

        -- Tab bar config
        config.use_fancy_tab_bar = false
        config.colors = {
          tab_bar = {
            background = main_palette.base,
            active_tab = {
              bg_color = main_palette.highlight_med,
              fg_color = main_palette.text,
            },
            inactive_tab = {
              bg_color = main_palette.base,
              fg_color = main_palette.muted,
            },
            inactive_tab_hover = {
              bg_color = main_palette.highlight_low,
              fg_color = main_palette.muted,
            },
            new_tab = {
              bg_color = main_palette.base,
              fg_color = main_palette.text,
            },
            new_tab_hover = {
              bg_color = main_palette.highlight_low,
              fg_color = main_palette.text,
            },
          },
        }
        config.tab_max_width = 32

        config.enable_scroll_bar = true
        config.font = wezterm.font_with_fallback {
          'Hack Nerd Font',
          'Source Han Sans SC',
        }
        config.font_size = 11.0
        return config
      '';
    };
  };
}
