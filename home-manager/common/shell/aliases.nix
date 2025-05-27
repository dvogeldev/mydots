_: {
  programs.fish.shellAliases = {
    # Utilities
    ".." = "cd ..";
    "..." = "cd ../..";
    "...." = "cd ../../..";
    "....." = "cd ../../../..";
    cl = "clear";
    cla = "clear && ls -la";
    cll = "clear && eza -lh --group-directories-first";
    cls = "clear && ls";
    # Nixos
    nrb = "sudo nixos-rebuild boot --flake ~/mydots#dvpc";
    nrs = "sudo nixos-rebuild switch --flake ~/mydots#dvpc";
    nrt = "sudo nixos-rebuild test --flake ~/mydots#dvpc";
    hms = "home-manager switch --flake ~/mydots#david@dvpc";
    sr = "sudo reboot";
    # Eza
    ls = "eza --group-directories-first --icons --color-scale";
    lt = "eza --tree --level=2 --icons";
    l = "ls -a";
    ld = "l -D";
    ll = "ls -lbG --git";
    la = "ll -a";
    lC = "la --sort=changed";
    lM = "la --sort=modified";
    lS = "la --sort=size";
    lX = "la --sort=extension";
    # Program shortcuts
    v = "nvim";
    free = "free -h";
    # Git
    gall = "git add .";
    lg = "lazygit";
    gcom = "git commit -m";
    gd = "git diff";
    gf = "git fetch";
    gl = "git log";
    gph = "git push";
    gpl = "git pull";
    gs = "git status";
    # YT-DLP
    ytda = "yt-dlp -f bestaudio --extract-audio --audio-format ops --audio-quality 0";
    ytd = "yt-dlp -f bestaudio+bestvideo --merge-output-format mp4";
  };
}
