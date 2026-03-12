{
  outputs,
  config,
  lib,
  pkgs,
  colorscheme,
  inputs,
  ...
}:
let
  commonDeps = with pkgs; [
    coreutils
    gnugrep
    systemd
  ];
  # Function to simplify making waybar outputs
  mkScript =
    {
      name ? "script",
      deps ? [ ],
      script ? "",
    }:
    lib.getExe (
      pkgs.writeShellApplication {
        inherit name;
        text = script;
        runtimeInputs = commonDeps ++ deps;
      }
    );
  # Specialized for JSON outputs
  mkScriptJson =
    {
      name ? "script",
      deps ? [ ],
      script ? "",
      text ? "",
      tooltip ? "",
      alt ? "",
      class ? "",
      percentage ? "",
    }:
    mkScript {
      inherit name;
      deps = [ pkgs.jq ] ++ deps;
      script = ''
        ${script}
        jq -cn \
          --arg text "${text}" \
          --arg tooltip "${tooltip}" \
          --arg alt "${alt}" \
          --arg class "${class}" \
          --arg percentage "${percentage}" \
          '{text:$text,tooltip:$tooltip,alt:$alt,class:$class,percentage:$percentage}'
      '';
    };

  swayCfg = config.wayland.windowManager.sway;
  hyprlandCfg = config.wayland.windowManager.hyprland;
in
{
  systemd.user.services.waybar = {
    Unit = {
      # Let it try to start a few more times
      StartLimitBurst = 30;
      # Reload instead of restarting
      X-Restart-Triggers = lib.mkForce [ ];
      #X-Reload-Triggers = [
      #  "${config.xdg.configFile."waybar/config".source}"
      #  "${config.xdg.configFile."waybar/style.css".source}"
      #];
    };
  };
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oa: {
      mesonFlags = (oa.mesonFlags or [ ]) ++ [ "-Dexperimental=true" ];
    });
    style = ''
        * {
            border: none;
            border-radius: 16px;
            font-family: ${config.fontProfiles.monospace.name};
            font-size: 13px;
            font-style: normal;
            min-height: 0;
            font-weight: bold;
            color: #${colorscheme.base0F};
        }
        window#waybar {
            background-color: rgba(0, 0, 0, 0.5);
            border-radius: 10px;
            padding-top: 10px;
            margin-top: 10px;
            margin-left: 10px;
            margin-right: 10px;
        }
        #workspaces {
            background: #${colorscheme.base00};
            margin: 6.5px 5px;
            padding: 8px 5px;
            border-radius: 16px;
            border: solid 2px #${colorscheme.base02};
            font-weight: bold;
            font-style: normal;
        }
        #workspaces button {
            padding: 0px 5px;
            margin: 0px 3px;
            border-radius: 16px;
            color: #${colorscheme.base0F};
            background-color: #${colorscheme.base01};
            transition: all 0.2s ease-in-out;
        }
        #workspaces button.active {
            color: #${colorscheme.base00};
            background-color: #${colorscheme.base0E};
            border-radius: 16px;
            min-width: 40px;
            background-size: 400% 400%;
            transition: all 0.2s ease-in-out;
        }
        #workspaces button:hover {
            background-color: #${colorscheme.base03};
            color: #${colorscheme.base00};
            border-radius: 16px;
            min-width: 30px;
            background-size: 400% 400%;
            transition: all 0.2s ease-in-out;
        }
        #cpu,
        #custom-gpu,
        #memory,
        #clock,
        #custom-unread-mail {
            background: rgba(0, 0, 0, 0.5);
            border-radius: 23px;
            border: solid 0.4px #${colorscheme.base0A};
            margin: 12px 2px;
            padding: 2px 6px;
            color: #${colorscheme.base05};
            font-size: 12px;
        }

        #tray,
        #custom-rfkill,
        #network,
        #pulseaudio,
        #battery {
            padding: 0 1px;
            margin: 14px 1px;
            border: solid 2px #${colorscheme.base02};
            background-color: #${colorscheme.base01};
            color: #${colorscheme.base0F};
            font-size: 12px;
        }
        
    '';
    systemd.enable = true;
    settings = {
      primary = {
        exclusive = false;
        passthrough = false;
        height = 45;
        margin = "0";
        position = "top";
        modules-left = [
        ]
        ++ (lib.optionals swayCfg.enable [
          "sway/workspaces"
          "sway/mode"
        ])
        ++ (lib.optionals hyprlandCfg.enable [
          "hyprland/workspaces"
          "hyprland/submap"
        ])
        ++ [
          "custom/currentplayer"
          "custom/player"
        ];

        modules-center = [
          "cpu"
          "custom/gpu"
          "memory"
          "clock"
          "custom/unread-mail"
        ];

        modules-right = [
          "tray"
          "custom/rfkill"
          "network"
          "pulseaudio"
          "battery"
        ];

        clock = {
          interval = 1;
          format = "{:%d/%m %H:%M:%S}";
          format-alt = "{:%Y-%m-%d %H:%M:%S %z}";
          on-click-left = "mode";
          tooltip-format = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
        };

        cpu = {
          format = "  {usage}%";
        };
        "custom/gpu" = {
          interval = 5;
          exec = mkScript { script = "cat /sys/class/drm/card*/device/gpu_busy_percent | head -1"; };
          format = "󰒋  {}%";
        };
        memory = {
          format = "  {}%";
          interval = 5;
        };

        pulseaudio = {
          format-source = "󰍬 {volume}%";
          format-source-muted = "󰍭 0%";
          format = "{icon} {volume}% {format_source}";
          format-muted = "󰸈 0% {format_source}";
          format-icons = {
            default = [
              "󰕿"
              "󰖀"
              "󰕾"
            ];
          };
          on-click = lib.getExe pkgs.pavucontrol;
        };
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "󰒳";
            deactivated = "󰒲";
          };
        };
        battery = {
          bat = "BAT1";
          interval = 10;
          format-icons = [
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          onclick = "";
        };
        "sway/window" = {
          max-length = 20;
        };
        network = {
          interval = 3;
          format-wifi = "   {essid}";
          format-ethernet = "󰈁 Connected";
          format-disconnected = "";
          tooltip-format = ''
            {ifname}
            {ipaddr}/{cidr}
            Up: {bandwidthUpBits}
            Down: {bandwidthDownBits}'';
        };
        "custom/menu" = {
          interval = 1;
          return-type = "json";
          exec = mkScriptJson {
            deps = lib.optional hyprlandCfg.enable hyprlandCfg.package;
            text = "";
            tooltip = ''$(grep PRETTY_NAME /etc/os-release | cut -d '"' -f2)'';
            class =
              let
                isFullScreen =
                  if hyprlandCfg.enable then "hyprctl activewindow -j | jq -e '.fullscreen' &>/dev/null" else "false";
              in
              "$(if ${isFullScreen}; then echo fullscreen; fi)";
          };
        };
        "custom/hostname" = {
          exec = mkScript {
            script = ''
              echo "$USER@$HOSTNAME"
            '';
          };
          on-click = mkScript {
            script = ''
              systemctl --user restart waybar
            '';
          };
        };
        "custom/unread-mail" = {
          interval = 5;
          return-type = "json";
          exec = mkScriptJson {
            deps = [
              pkgs.findutils
              pkgs.procps
            ];
            script = ''
              count=$(find ~/Mail/*/Inbox/new -type f | wc -l)
              if pgrep mbsync &>/dev/null; then
                status="syncing"
              else
                if [ "$count" == "0" ]; then
                  status="read"
                else
                  status="unread"
                fi
              fi
            '';
            text = "$count";
            alt = "$status";
          };
          format = "{icon}  ({})";
          format-icons = {
            "read" = "󰇯";
            "unread" = "󰇮";
            "syncing" = "󰁪";
          };
        };
        "custom/currentplayer" = {
          interval = 2;
          return-type = "json";
          exec = mkScriptJson {
            deps = [ pkgs.playerctl ];
            script = ''
              all_players=$(playerctl -l 2>/dev/null)
              selected_player="$(playerctl status -f "{{playerName}}" 2>/dev/null || true)"
              clean_player="$(echo "$selected_player" | cut -d '.' -f1)"
            '';
            alt = "$clean_player";
            tooltip = "$all_players";
          };
          format = "{icon}{}";
          format-icons = {
            "" = " ";
            "Celluloid" = "󰎁 ";
            "spotify" = "󰓇 ";
            "ncspot" = "󰓇 ";
            "qutebrowser" = "󰖟 ";
            "firefox" = " ";
            "discord" = " 󰙯 ";
            "sublimemusic" = " ";
            "kdeconnect" = "󰄡 ";
            "chromium" = " ";
          };
        };
        "custom/player" = {
          exec-if = mkScript {
            deps = [ pkgs.playerctl ];
            script = ''
              selected_player="$(playerctl status -f "{{playerName}}" 2>/dev/null || true)"
              playerctl status -p "$selected_player" 2>/dev/null
            '';
          };
          exec = mkScript {
            deps = [ pkgs.playerctl ];
            script = ''
              selected_player="$(playerctl status -f "{{playerName}}" 2>/dev/null || true)"
              playerctl metadata -p "$selected_player" \
                --format '{"text": "{{artist}} - {{title}}", "alt": "{{status}}", "tooltip": "{{artist}} - {{title}} ({{album}})"}' 2>/dev/null
            '';
          };
          return-type = "json";
          interval = 2;
          max-length = 30;
          format = "{icon} {}";
          format-icons = {
            "Playing" = "󰐊";
            "Paused" = "󰏤 ";
            "Stopped" = "󰓛";
          };
          on-click = mkScript {
            deps = [ pkgs.playerctl ];
            script = "playerctl play-pause";
          };
        };
        "custom/rfkill" = {
          interval = 1;
          exec-if = mkScript {
            deps = [ pkgs.util-linux ];
            script = "rfkill | grep '\<blocked\>'";
          };
        };
      };
    };
  };
}
