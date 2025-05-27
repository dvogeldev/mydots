{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    aria2
    ffmpeg
  ];

  programs.yt-dlp = {
    enable = true;
    settings = {
      embed-metadata = true;
      embed-thumbnail = true;
      restrict-filenames = true;
      ignore-errors = true;
      output = "~/Downloads/%(title)s.%(ext)s";
      downloader = "aria2c";
    };
    extraConfig = ''
      --downloader-args aria2c:"-x 16 -s 16 -k 1M"
    '';
  };

  home.shellAliases = {
    ydl-opus = "yt-dlp -f 'bestaudio[acodec=opus]' -x --audio-format opus --audio-quality 0 -o '~/Downloads/%(title)s.%(ext)s'";
    ydl-mp4 = "yt-dlp -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]' --merge-output-format mp4 -o '~/Downloads/%(title)s.%(ext)s'";
  };
}
