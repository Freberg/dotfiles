{ config, pkgs, lib, ... }:
{
    systemd.user.timers = {
        antivirus-scan = {
            Unit.Description = "timer for antivirus-scan";
            Install.WantedBy = [ "timers.target" ];
            Timer = {
                OnBootSec = "15min";
                OnUnitActiveSec = "1w";
                Persistent = true;
                Unit = "antivirus-scan.service";
            };
        };
    };
    systemd.user.services = {
        antivirus-scan = {
            Unit.Description = "service for antivirus-scan";
            Install.WantedBy = [ "default.target" ];
            Service = {
                Type = "oneshot";
                ExecStart = toString (pkgs.writeShellScript "anti-virus-script" ''
                    PATH=$PATH:${lib.makeBinPath [ pkgs.coreutils pkgs.libnotify pkgs.clamav ]}
                    ${pkgs.bash}/bin/bash "/home/freberg/.config/scripts/antivirus-scan.sh";
                '');
            };
        };
    };
}
