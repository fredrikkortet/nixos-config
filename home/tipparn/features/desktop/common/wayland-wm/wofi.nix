{
  config,
  lib,
  pkgs,
  colorscheme,
  ...
}:
{
  programs.wofi = {
    enable = true;
    settings = {
      image_size = 48;
      columns = 3;
      allow_images = true;
      insensitive = true;
      run-always_parse_args = true;
      run-cache_file = "/dev/null";
      run-exec_search = true;
      matching = "multi-contains";
    };
    style = ''
      window {
          border-radius: 17px;
          background-color: rgba(30, 30, 30, 0.99);
          margin: 0px;
          border: 1px solid #${colorscheme.base0E};
          }

      #input {
          margin: 5px;
          border: none;
          color: #${colorscheme.base05};
          background-color: #${colorscheme.base02};
          }

      #inner-box {
          margin: 5px;
          border: none;
          background-color: #${colorscheme.base00};
          }

      #outer-box {
          margin: 5px;
          border: none;
          background-color: #${colorscheme.base00};
          }

      #scroll {
          margin: 0px;
          border: none;
          }

      #text {
          margin: 5px;
          border: none;
          color: #${colorscheme.base05};
          } 

      #entry.activatable #text {
          color: #${colorscheme.base00};
          }

      #entry > * {
          color: #${colorscheme.base05};
          }

      #entry:selected {
          background-color: #${colorscheme.base02};
          }

      #entry:selected #text {
          font-weight: bold;
          } 
    '';
  };

}
