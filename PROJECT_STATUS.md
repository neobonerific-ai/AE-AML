# Project Status

## Phase
Baseline build (AlexELEC 3.3.3 S812/M8S) in progress.

## Last Run
Run ID: 42544469404 completed failure (44d71ba, libgpg-error gawk `namespace` builtin).
Ursache: Build kam bis libgpg-error durch (vorige Fixes wirken, incl. curl); libgpg-error make scheitert mit `gawk: fatal: cannot use gawk builtin 'namespace' as variable name`.
Fix: Patch packages/security/libgpg-error/patches/0001-fix-gawk-namespace-builtin.patch als Commit `169793b` gepusht; Verifizierungs-Run **42552793592** (workflow_dispatch) bei `169793b` ausgeloest, status **in_progress**.

## Fixes Applied
- Host deps xfonts-utils, libxml-parser-perl
- make:host __stat (CFLAGS -D__stat=stat)
- m4:host SIGSTKSZ patch (0003-c-stack-stop-using-SIGSTKSZ.patch)
- linux:host full commit SHA + verified SHA256
- binutils gold missing <string> include
- binutils gold narrowing conversion (pr_type)
- binutils gold patch: correct hunk headers and context
- Workflow: concurrency, diagnostic logs, output verification, log filename sanitization
- libcap:host URL (kernel.org 404 -> mirrors.edge.kernel.org)
- fakeroot:host _STAT_VER=0 for modern glibc
- nss:host disable return-local-addr error (modern gcc)
- glib:host disable format-overflow error (modern gcc)
- glib:host explicit host CFLAGS via pre_configure_host() export (vermeidet Wortzerlegung durch unquoted PKG_CONFIGURE_OPTS_HOST)
- ccache: key ohne github.sha (Cache-Wiederverwendung zwischen Builds)
- kodi: JsonSchemaBuilder:host entfernt (interner Kodi-Build)
- kodi: TexturePacker:host entfernt (interner Kodi-Build)
- curl: --with-libssh2 entfernt (libssh2 nicht im Build-Baum / nicht als Dependenz; configure-Fehler libSSH2 not found)
- libgpg-error: gawk `namespace`-Builtin-Konflikt (gawk >= 5.1 reserviert `namespace`; `gawk: fatal: cannot use gawk builtin 'namespace' as variable name` bei `-v namespace=errnos_` in src/Makefile.in). Patch packages/security/libgpg-error/patches/0001-fix-gawk-namespace-builtin.patch renamed `namespace` -> `gpg_error_namespace` in mkstrtable.awk + Makefile.in. PKG_VERSION/SHA256 unverändert.

## Open Tasks
- Verifizierungs-Run 42544469404 (workflow_dispatch, Fix 44d71ba curl --with-libssh2) ist **completed failure** bei 44d71ba — Build kam über curl durch (curl-Fix wirkt), neuer Root Cause: libgpg-error make scheitert mit `gawk: fatal: cannot use gawk builtin 'namespace' as variable name` (gawk >= 5.1 auf dem Runner; libgpg-error 1.35 übergibt `-v namespace=errnos_`). Minimaler Fix: Patch packages/security/libgpg-error/patches/0001-fix-gawk-namespace-builtin.patch (`namespace` -> `gpg_error_namespace`; SHA256/Version unverändert) als Commit `169793b` gepusht. Da der Workflow `workflow_dispatch`-nur ist: Verifizierungs-Run **42552793592** bei `169793b` manuell ausgeloest — laeuft. Naechster Zyklus: Run 42552793592 auswerten, bei Erfolg Artefakte (.img.gz, .tar) + SHA256SUMS prüfen und Baseline abschliessen, bei Misserfolg neue Diagnose.
- Complete baseline image build + artifacts + checksums.

## Processed Runs
- 41951664521 (deps)
- 41952487939 / 41952494598 (make)
- 42013162205 (m4)
- 42023886447 (linux/binutils) in progress
- 42027732135 (failure)
- 42031730689 (failure)
- 42035914803 (failure)
- 42038991766 (failure, fixed by b8393f3)
- 42046808201 (failure, fixed by 0a33f04 - libcap url)
- 42050799596 (failure, fixed by 186c0e8 - fakeroot _STAT_VER)
- 42054945417 (failure, fixed by 258faf8 - fakeroot CFLAGS env)
- 42054992145 (failure, fixed by 09f0c1f - fakeroot HOST_CFLAGS)
- 42060246240 (failure, fixed by a509c0c - p7zip narrowing)
- 42062739704 (failure, fixed by ac1a0e4 - fakeroot _STAT_VER source patch)
- 42075031696 (cancelled, a509c0c)
- 42075055502 (cancelled, e9f65bf)
- 42076040456 (cancelled, e1a369a)
- 42080892029 (cancelled, ac1a0e4)
- 42089674016 (failure, fixed by fakeroot CFLAGS env removal)
- 42109691763 (cancelled, superseded by 42110547576)
- 42110547576 (failure at e05c1ca, pre-squashfs-fix; superseded by 42116110250)
- 42100244040 (cancelled, 643c1ae)
- 42116110250 (failure, fixed by 8fbd3f3 - fakeroot source patch via find)
- 42125755256 (failure, fixed by 53b9081 - cpio -fcommon)
- 42125766859 (failure, superseded by 53b9081 - cpio fix; sha d7869e9 pre-fix)
- 42100301559 (failure, fixed by b2b847d - squashfs -fcommon)
- 42134780309 (failure, fixed by 32484d1 - linux host dtc -fcommon)
- 42147839351 (failure, fixed by ba569c6 - gpu-aml pin full SHA + SHA256)
- 42147858736 (failure at 5dde57a, pre-gpu-aml-fix; superseded by ba569c6)
- 42156172108 (failure, fixed by 7c3b072 - JsonSchemaBuilder PKG_TOOLCHAIN=cmake)
- 42169923328 (failure, fixed by c98b824 - JsonSchemaBuilder PKG_CMAKE_SCRIPT own build dir)
- 42169943705 (failure, fixed by 236db32 - JsonSchemaBuilder:host revert to MEDIACENTER build dir)
- 42178931409 (failure - JsonSchemaBuilder:host source dir absent, superseded by 6b054ef)
- 42213571615 (failure, fixed by 6829f8a - JsonSchemaBuilder:host in S812 project kodi)
- 42471939790 (failure, fixed by edb9166 - glib:host HOST_CFLAGS)
- 42532438850 (failure at 845b585, glib:host CFLAGS word-splitting; fixed by glib:host export CFLAGS via pre_configure_host)
- 42536833978 (failure at 90646b8, curl --with-libssh2 without libssh2 dep; fixed by removing --with-libssh2)
- 42544469404 (failure at libgpg-error gawk `namespace` builtin; fixed by 169793b)
