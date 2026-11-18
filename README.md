# For Audi A4 B9 running mib2q-carplay 1.5+

`apply/mod/custom.sh` creates or overwrites two files:

`/mnt/app/root/aa_cluster.insets` with the following contents:

```text
47 166 130 290
47 166 510 510
58 166 484 394
```

`/mnt/app/root/aa_cluster.dpi` containing a single number, `125`.

Valid values are integers from 80 to 400. The same value applies to Full, Classic and Sport. Higher DPI makes UI elements larger.

`restore/mod/custom.sh` deletes both files if they exist, restoring the release's built-in insets and DPI 125.

The scripts do not create backups or logs, modify libraries, or check versions or checksums. They use the standard `mount -uw /mnt/app` command to enable writing on the MMI. When launched on another node, execution is forwarded to mmx using `on`. `command.sh` is a compatibility wrapper for the M.I.B. menu.

Disconnect the phone, copy the contents of `apply` to the root of the M.I.B. card, replacing the two files in `mod`, then select `GEM → M.I.B. → Advanced Settings → Run individual script`. Wait for `DONE`, then reconnect the phone.

To restore the built-in insets and DPI, copy the contents of `restore` to the card root and select the same menu item. Reconnect the phone afterward. This deletes the files rather than restoring their previous contents.
