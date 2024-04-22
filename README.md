# FsWarn

Alpine based rootfs containing everything needed to warn the users that FsGuard failed the filesystem verification.

## Building

Building FsWarn is only possible on Alpine Linux, a container can be used for this purpose.

```sh
apk add xz squashfs-tools
./genrootfs.sh
```

The resulting squashfs image will be saved in the working directory as `fswarn-x86_64.squash`
