#!/bin/bash -e

cleanup() {
	rm -rf "$tmp"
}

tmp="$(mktemp -d)"
trap cleanup EXIT
chmod 0755 "$tmp"

arch="x86_64"
repositories_file=/etc/apk/repositories
keys_dir=/etc/apk/keys
outfile="./fswarn-x86_64.squash"

packages="alpine-baselayout-data busybox imagemagick gawk bash"

cat "$repositories_file"

if [ -z "$outfile" ]; then
	outfile=fswarn-$arch.squash
fi

${APK:-apk} add --keys-dir "$keys_dir" --no-cache \
	--repositories-file "$repositories_file" \
	--no-script --root "$tmp" --initdb --arch "$arch" \
	$packages
for link in $("$tmp"/bin/busybox --list-full); do
	[ -e "$tmp"/$link ] || ln -s /bin/busybox "$tmp"/$link
done

${APK:-apk} fetch --keys-dir "$keys_dir" --no-cache \
	--repositories-file "$repositories_file" --root "$tmp" \
	--stdout --quiet alpine-release | tar -zx -C "$tmp" etc/

# make sure root login is disabled
sed -i -e 's/^root::/root:*:/' "$tmp"/etc/shadow

branch=edge
VERSION_ID=$(awk -F= '$1=="VERSION_ID" {print $2}'  "$tmp"/etc/os-release)
case $VERSION_ID in
*_alpha*|*_beta*) branch=edge;;
*.*.*) branch=v${VERSION_ID%.*};;
esac

cat > "$tmp"/etc/apk/repositories <<EOF
https://dl-cdn.alpinelinux.org/alpine/$branch/main
https://dl-cdn.alpinelinux.org/alpine/$branch/community
EOF

cp ./vanillaos_verification_fail.png "$tmp"/verification_failed.png
cp ./vanillaos_continue_confirm.png "$tmp"/continue_confirm.png

mksquashfs $tmp "$outfile" -comp xz
