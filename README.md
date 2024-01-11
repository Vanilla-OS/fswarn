# FsWarn
alpine based rootfs containing everything needed to warn the users that FsGuard failed the filesystem verification

## Building:
The build can only be done in alpine linux, a container can be used for this.
```
apk add xz squashfs-tools
./genrootfs.sh
```
The resulting squashfs image will be saved in the working directory as `fswarn-x86_64.squash`
