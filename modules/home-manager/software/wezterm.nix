{ pkgs, ... }:

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

      config.enable_scroll_bar = true
      config.use_fancy_tab_bar = false
      config.font = wezterm.font("Hack Nerd Font", {weight="Regular", stretch="Normal", style="Normal"})
      config.font_size = 11.0
      config.window_background_opacity = 0.8

      return config
    '';
  };
}
