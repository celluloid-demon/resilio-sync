# download-stream

A simple docker service for running resilio-sync.

## How to use

1. Run `build.sh` from `./local/build-sample-config`.
2. Move the sample config file `./local/build-sample-config/build/rslsync.conf` to `./config/` (make the directory if missing).
3. Customize `./config/rslsync.conf`.
    - change ownership from root to your personal username
4. Run `up.sh`.

## Optional

- Run `./update-cron.sh` to automatically run on a schedule (edit cron settings in `./settings`).
