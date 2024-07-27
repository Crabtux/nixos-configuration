{ ... }:

{
  programs.wezterm = {
    enable = true;
    enableBashIntegration = true;

    extraConfig = ''
      local wezterm = require 'wezterm'
      local config = {}

      -- In newer versions of wezterm, use the config_builder which will
      -- help provide clearer error messages
      if wezterm.config_builder then
        config = wezterm.config_builder()
      end

      config.color_scheme = 'rose-pine'
      config.enable_scroll_bar = true
      config.use_fancy_tab_bar = false
      config.tab_max_width = 32
      config.font = wezterm.font_with_fallback {
        'Hack Nerd Font',
        'Source Han Sans SC',
      }
      config.font_size = 11.0
      return config
    '';
  };
}
