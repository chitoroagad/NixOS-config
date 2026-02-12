{pkgs, ...}: let
  script =
    pkgs.writers.writePython3Bin "clean-torrents" {flakeIgnore = ["E111"];}
    ''
      # Script to clean unused torrent files when they are held in
      # same dir as content
      import os
      import sys


      def clean_torrents(directory, delete=False):
        removed = 0

        for entry in os.listdir(directory):
          if not entry.lower().endswith(".torrent"):
            continue

          torrent_path = os.path.join(directory, entry)
          base_name = os.path.splitext(entry)[0]
          matching_path = os.path.join(directory, base_name)

          if not os.path.exists(matching_path):
            if delete:
              print(f"Removing orphaned torrent: {entry}")
              os.remove(torrent_path)
              removed += 1
            else:
              print(f"[DRY RUN] Would remove: {entry}")

        if delete:
          print(f"\nDone. Removed {removed} torrent(s).")
        else:
          print("\nDry run complete. No files were removed.")


      if __name__ == "__main__":
        if len(sys.argv) < 2:
          print("Usage:\n\tclean_torrents <directory> [--delete]")
          sys.exit(1)

          target_dir = sys.argv[1]
          delete_mode = "--delete" in sys.argv

          if not os.path.isdir(target_dir):
            print("Error: Provided path is not a directory")
            sys.exit(1)

          clean_torrents(target_dir, delete=delete_mode)
    '';
in {
  home.packages = [script];
}
