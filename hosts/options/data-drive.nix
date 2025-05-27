{
  config,
  lib,
  pkgs,
  ...
}: {
  # Auto scrubbing
  services.btrfs.autoScrub = {
    enable = true;
    fileSystems = [ "/data" ];
    interval = "weekly";
  };

  fileSystems."/data" = {
    device = "/dev/disk/by-uuid/228658b0-3460-4e0d-87d5-f73a4a7a9b12"; # Replace with actual UUID
    fsType = "btrfs";
    options = [
      # Basic mount options
      "defaults"
      "noatime" # Reduces disk writes by not recording access times
      "space_cache=v2" # Better space cache management
      "autodefrag" # Automatic defragmentation for HDDs

      # HDD-specific optimizations
      "nossd" # Disables SSD-specific optimizations
      "commit=120" # Longer commit intervals (default is 30s)

      # Error handling
      "device=/dev/disk/by-uuid/228658b0-3460-4e0d-87d5-f73a4a7a9b12" # Explicitly specify device
      "subvol=@"
    ];
  };

  # Subvolume mount points
  fileSystems."/data/dots" = {
    device = "/dev/disk/by-uuid/228658b0-3460-4e0d-87d5-f73a4a7a9b12";
    fsType = "btrfs";
    options = ["subvol=@dots" "noatime" "nossd" "space_cache=v2" "autodefrag"];
  };

  fileSystems."/data/pics" = {
    device = "/dev/disk/by-uuid/228658b0-3460-4e0d-87d5-f73a4a7a9b12";
    fsType = "btrfs";
    options = ["subvol=@pics" "noatime" "nossd" "space_cache=v2" "autodefrag"];
  };

  fileSystems."/data/projects" = {
    device = "/dev/disk/by-uuid/228658b0-3460-4e0d-87d5-f73a4a7a9b12";
    fsType = "btrfs";
    options = ["subvol=@projects" "noatime" "nossd" "space_cache=v2" "autodefrag"];
  };

  fileSystems."/data/archive" = {
    device = "/dev/disk/by-uuid/228658b0-3460-4e0d-87d5-f73a4a7a9b12";
    fsType = "btrfs";
    options = ["subvol=@archive" "noatime" "nossd" "space_cache=v2" "autodefrag"];
  };

  fileSystems."/data/music" = {
    device = "/dev/disk/by-uuid/228658b0-3460-4e0d-87d5-f73a4a7a9b12";
    fsType = "btrfs";
    options = ["subvol=@music" "noatime" "nossd" "space_cache=v2" "autodefrag"];
  };

  fileSystems."/data/videos" = {
    device = "/dev/disk/by-uuid/228658b0-3460-4e0d-87d5-f73a4a7a9b12";
    fsType = "btrfs";
    options = ["subvol=@videos" "noatime" "nossd" "space_cache=v2" "autodefrag"];
  };

  fileSystems."/data/backup" = {
    device = "/dev/disk/by-uuid/228658b0-3460-4e0d-87d5-f73a4a7a9b12";
    fsType = "btrfs";
    options = ["subvol=@backup" "noatime" "nossd" "space_cache=v2" "autodefrag"];
  };

  # Create the mount points
  systemd.tmpfiles.rules = [
    "d /data 0755 david users"
    "d /data/dots 0755 david users"
    "d /data/pics 0755 david users"
    "d /data/projects 0755 david users"
    "d /data/archive 0755 david users"
    "d /data/music 0755 david users"
    "d /data/videos 0755 david users"
    "d /data/backup 0755 david users"
  ];
}
