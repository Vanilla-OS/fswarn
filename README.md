# FsWarn

Alpine based rootfs containing everything needed to warn the users that FsGuard failed the filesystem verification.

## Building

Building FsWarn is only possible on Alpine Linux, a container can be used for this purpose.

```sh
apk add xz squashfs-tools
./genrootfs.sh
```

The resulting squashfs image will be saved in the working directory as `fswarn-x86_64.squash`

## Use of Generative AI

Maintainers may use generative AI tools as assistants while working on fswarn. Non-trivial assisted commits disclose the tool, model, and scope of the work.

AI tools may assist with code comments, documentation, repetitive code, and issue triage. Maintainers make project decisions and review every assisted change before it is merged.

Use these trailers for non-trivial assisted commits:

```plain
Assisted-by: <tool>:<model-version>
AI-Scope: <what the tool generated and the prompt or a short prompt summary>
```

Single-line completions, renames, and formatting changes do not need trailers.

Coding agents must also follow [AGENTS.md](AGENTS.md) before changing files,
creating commits, or opening pull requests.
