# etc

Unit files and configuration for the home server.

## setup

zfs comes with systemd units for scrubbing, under `/lib/systemd/system`.

```
sudo systemctl enable zfs-scrub-monthly@pool.timer --now
```

zed needs configuring, first set up msmtp from here https://gist.github.com/simonhorlick/e2a136dfc9917e8114bc09add7a4084d

```
sudo systemctl start zfs-zed.service
sudo systemctl enable zfs-zed.service
```
