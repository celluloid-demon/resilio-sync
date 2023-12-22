# resilio-sync

A simple docker service for running resilio-sync.

## How to use

1. Run `build.sh` from `./local/build-sample-config`.
    - change ownership from root to your personal username
2. Move the sample config file `./local/build-sample-config/build/rslsync.conf` to `./config/` (make the directory if missing - better, symlink "config" from project root to `"$HOME/Documents/Resilio Sync/Devices/<chosen device name from config>/config"`).
3. Customize `./config/rslsync.conf`.
4. Symlink `./local/sync` from project root to `"$HOME/Documents/Resilio Sync/Devices/<chosen device name from config>/sync"`
5. Run `up.sh`.

## Optional

- Run `./update-cron.sh` to automatically run on a schedule (edit cron settings in `./settings`).
- If running on a personal linux machine with KDE, you can add `up.sh` as an autostart script.
