# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, pkgs, outputs, ... }:

{
  imports =
    [ 
      ../../profiles/nixos/desktop.nix
      ./hardware-configuration.nix
      outputs.nixosModules.rain
    ];

  networking.hostName = "TX-Air";

  # Configure the NVIDIA graphic card.
  boot.blacklistedKernelModules = [ "nouveau" ];

  hardware.nvidia = {
    open = true;
    powerManagement.enable = true;
    powerManagement.finegrained = true;
    prime = {
      offload.enable = true;
      offload.enableOffloadCmd = true;
      amdgpuBusId = "PCI:66:00:0"; 
      nvidiaBusId = "PCI:64:00:0";
    };
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  hardware.opengl.enable = true;

  services.xserver.videoDrivers = [ "amdgpu" ];

  # Thank you, Gemini 3 Pro!
  # An workaround used to fix an issue of screen freezing on idle with amdgpu
  services.xserver.deviceSection = ''
    Option "TearFree" "true"
  '';

  # Thank you again, Gemini 3 Pro!
  # 另一个 workaround，用来修开机卡顿 36s 的问题
  # See also: https://www.bilibili.com/opus/1104887054270988297
  boot.kernelParams = [
    "initcall_blacklist=acpi_gpio_handle_deferred_request_irqs"
  ];

  # 省电策略
  environment.systemPackages = with pkgs; [
    powertop
  ];

  services.tlp = {
    enable = true;
    settings = {
      TLP_ENABLE = 1;
      
      # 调速器 (Governor)
      # 现代 AMD CPU 通常使用 amd-pstate 驱动，"powersave" 其实是把频率交给 EPP 管理
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      # 能量性能偏好 (EPP) - 这才是控制频率的核心
      # performance: 满血; balance_performance: 均衡; power: 省电
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";

      # 睿频控制 (Turbo Boost)
      # 电池模式下关掉睿频，能大幅降温和省电
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;

      # 这会联动你的 ASUS BIOS 里的风扇策略 (Fn+F 切换的那个模式)
      # performance: 风扇转得快; low-power: 静音/省电
      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "low-power";

      # 运行时电源管理 (Runtime PM)
      # 强制所有 PCI 设备（包括显卡）在闲置时挂起
      RUNTIME_PM_ON_AC = "auto"; 
      RUNTIME_PM_ON_BAT = "auto";
      
      # 排除特定的 PCI 设备
      RUNTIME_PM_DENYLIST="66:00.0";

      # PCIe 活动状态电源管理 (ASPM)
      # powersupersave 是最强省电，如果遇到系统死机改回 default
      PCIE_ASPM_ON_AC = "default";
      PCIE_ASPM_ON_BAT = "default";

      # TLP 会尝试对这些显卡类型应用省电规则
      RADEON_DPM_PERF_LEVEL_ON_AC = "auto";
      RADEON_DPM_PERF_LEVEL_ON_BAT = "auto";
      
      RADEON_POWER_PROFILE_ON_AC = "default";
      RADEON_POWER_PROFILE_ON_BAT = "default";
      
      # WiFi 省电模式
      WIFI_PWR_ON_AC = "off";
      WIFI_PWR_ON_BAT = "on";
    };
  };

  # services.power-profiles-daemon.enable = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?
}

