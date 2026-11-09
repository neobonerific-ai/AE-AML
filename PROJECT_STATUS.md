# Project Status

## Phase
Baseline build (AlexELEC 3.3.3 S812/M8S) in progress.

## Last Run
Run ID: 42544469404 completed failure (44d71ba, libgpg-error gawk `namespace` builtin) — processed.
Run ID: 42552793592 completed failure (169793b, kodi source SHA256 mismatch) — processed.
Run ID: 42641596480 completed failure (e9ad15c, TexturePacker:host cmake configure fails at find_package(Lzo2) — kodi's FindLzo2.cmake/FindGIF.cmake in cmake/modules not on standalone host build's CMAKE_MODULE_PATH), fixed by 2f987c8.
Run ID: 42563032671 completed failure (0f8f77f, kodi CMake configure) — processed, fixed by b627262.
Ursache 42563032671: Patch kodi-100.25-hack-fix-texture-packer-cmake-source-dir.patch setzt in kodi's tools/depends/native/TexturePacker/CMakeLists.txt `set(CMAKE_SOURCE_DIR ${CMAKE_SOURCE_DIR}/../../../..)`. Geschrieben fuer TexturPacker:host als Standalone-Paket; jetzt baut kodi TexturePacker intern (find_package -> add_subdirectory), CMAKE_SOURCE_DIR ist bereits die Kodi-Root. Der Hack laeuft 4 Ebenen zu weit hoch -> /home/runner/work, also fehlt /home/runner/work/xbmc/guilib/XBTF.cpp -> CMake-Fehler -> BUILD FAILED kodi -> gesamtes Image-Build fehlgeschlagen. SHA256-Pruefung aktiv, Kodi-Version unveraendert, keine DTB/kernel/Python/libamcodec-Aenderungen.
Fix: Commit b627262 entfernt obsoleten Patch, gepusht nach kodi-19.4-m8s (b6272621d6f2c725be70d0716acb825d91725874). Push löst keinen Run aus (workflow_dispatch-only). Verifizierungs-Run **42574183011** bei b627262 completed failure: kodi build fails at generate_json_header — 'JsonSchemaBuilder::JsonSchemaBuilder: not found'. Ursache: nach Entfernung von JsonSchemaBuilder:host (6829f8a) baut kodi JsonSchemaBuilder intern (ALIAS Target), aber xbmc/interfaces/json-rpc/schema/CMakeLists.txt ruft es per bare COMMAND-Name auf, den CMake für ALIAS nicht auf den Executable-Pfad auflöst. Fix: Commit f4419b2, Patch kodi-100.27-fix-jsonschemabuilder-command.patch (COMMAND $<TARGET_FILE:JsonSchemaBuilder>), gepusht nach kodi-19.4-m8s. Verifizierungs-Run **42587355252** bei f4419b2 completed failure: 'Exec format error' (JsonSchemaBuilder als ARM-Binary gebaut, laeuft nicht auf dem x86_64-Builder). Root Cause identifiziert, Fix: Commit 48c3591 baut JsonSchemaBuilder als Host-Tool nach $TOOLCHAIN/bin/JsonSchemaBuilder + -DWITH_JSONSCHEMABUILDER=$TOOLCHAIN/bin (wie flatbuffers:host -> flatc), gepusht nach kodi-19.4-m8s. Neuer Verifizierungs-Run **42599919808** bei 48c3591 per workflow_dispatch ausgeloest — completed failure: CMake 'No target JsonSchemaBuilder' bei $<TARGET_FILE:JsonSchemaBuilder>. Root Cause: FindJsonSchemaBuilder.cmake erstellt im WITH_JSONSCHEMABUILDER-Pfad nur den namespaced IMPORTED Target JsonSchemaBuilder::JsonSchemaBuilder, es gibt kein bare Alias-Target 'JsonSchemaBuilder'. Der Generator-Ausdruck $<TARGET_FILE:JsonSchemaBuilder> loest daher nicht auf. Fix: Commit 0d955b4, Patch kodi-100.27 auf $<TARGET_FILE:JsonSchemaBuilder::JsonSchemaBuilder> (namespaced Target, funktioniert in beiden Pfaden), gepusht nach kodi-19.4-m8s. Neuer Verifizierungs-Run **42615004151** bei 0d955b4 completed failure (pack-skins: TexturePacker::TexturePacker nicht gefunden, Error 127). Fix: Commit 2227473, Patch kodi-100.28 auf \$<TARGET_FILE:TexturePacker::TexturePacker>, gepusht nach kodi-19.4-m8s. Neuer Verifizierungs-Run **42629418207** bei 2227473 per workflow_dispatch ausgeloest.

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
- kodi: pack-skins TexturePacker::TexturePacker als bare COMMAND nicht aufgelöst (FindTexturePacker.cmake ALIAS/IMPORTED Target), gelöst via \$<TARGET_FILE:TexturePacker::TexturePacker> (kodi-100.28-fix-texturepacker-command.patch, commit 2227473)
- curl: --with-libssh2 entfernt (libssh2 nicht im Build-Baum / nicht als Dependenz; configure-Fehler libSSH2 not found)
- libgpg-error: gawk `namespace`-Builtin-Konflikt (gawk >= 5.1 reserviert `namespace`; `gawk: fatal: cannot use gawk builtin 'namespace' as variable name` bei `-v namespace=errnos_` in src/Makefile.in). Patch packages/security/libgpg-error/patches/0001-fix-gawk-namespace-builtin.patch renamed `namespace` -> `gpg_error_namespace` in mkstrtable.awk + Makefile.in. PKG_VERSION/SHA256 unverändert.

## Open Tasks
- Verifizierungs-Run 42544469404 (44d71ba) completed failure: libgpg-error gawk `namespace`, fixed by 169793b.
- Verifizierungs-Run 42587355252 (f4419b2) completed failure (Exec format error: JsonSchemaBuilder als ARM-Binary); fixed by 48c3591 (host JsonSchemaBuilder + -DWITH_JSONSCHEMABUILDER). Verifizierungs-Run 42599919808 (48c3591) completed failure ('No target JsonSchemaBuilder': namespaced vs bare target); fixed by 0d955b4 (Patch kodi-100.27 -> $<TARGET_FILE:JsonSchemaBuilder::JsonSchemaBuilder>). Neuer Verifizierungs-Run 42615004151 (0d955b4) completed failure: pack-skins 'TexturePacker::TexturePacker: Command not found' (Error 127). Fixed by 2227473 (Patch kodi-100.28 -> \$<TARGET_FILE:TexturePacker::TexturePacker>). Neue Verifizierungs-Run 42629418207 (2227473) completed failure: pack-skins fuehrt `build/texturepacker/TexturePacker` aus, das als ARM-Binary cross-kompiliert wurde und auf dem x86_64-Builder als Shell-Skript fehlschlaegt ('Syntax error: word unexpected'). Root Cause: FindTexturePacker.cmake baut TexturePacker ohne WITH_TEXTUREPACKER intern (add_subdirectory) statt das Host-Binary zu nutzen. Fix: Commit 800a5da (TexturePacker:host als PKG_DEPENDS_TARGET + -DWITH_TEXTUREPACKER=$TOOLCHAIN/bin in projects/S812/packages/kodi/package.mk; kodi-100.28 mit \$<TARGET_FILE:TexturePacker::TexturePacker> bleibt bestehen). Verifizierungs-Run **42641596480** bei e9ad15c completed failure: TexturePacker:host cmake configure fails at find_package(Lzo2) — kodi's FindLzo2.cmake/FindGIF.cmake in cmake/modules missing from standalone host build's CMAKE_MODULE_PATH. Fix: Commit 2f987c8 — TexturePacker:host PKG_CMAKE_OPTS_HOST += -DCMAKE_MODULE_PATH=$(get_build_dir $MEDIACENTER)/cmake/modules. Neuer Verifizierungs-Run **42658843775** bei 2f987c8 completed failure: TexturePacker:host configure laeuft jetzt durch ('-- Found Lzo2'), scheitert aber an add_executable: '${CMAKE_SOURCE_DIR}/xbmc/guilib/XBTF.cpp' nicht gefunden (Pfad relativ zum TexturePacker-Subdir statt Kodi-Root). Fix: kodi-100.29-fix-texturepacker-host-source-paths.patch legt Source/Include-Pfade auf CMAKE_CURRENT_SOURCE_DIR/../../../../ (Kodi-Root), laeuft standalone und im Kodi-Innenbuild. Nach Push workflow_dispatch-Verifizierung ausloesen.
- Complete baseline image build + artifacts + checksums.

## Processed Runs
- 41951664521 (deps)
- 42563032671 (failure at kodi TexturePacker CMAKE_SOURCE_DIR hack patch; fixed by b627262)
- 42574183011 (failure at kodi generate_json_header: JsonSchemaBuilder::JsonSchemaBuilder not found; fixed by f4419b2, verification run 42587355252 dispatched)
- 42587355252 (failure: Exec format error, JsonSchemaBuilder als ARM-Binary nicht ausfuehrbar auf dem x86_64-Builder; fixed by 48c3591 host-JsonSchemaBuilder + -DWITH_JSONSCHEMABUILDER, verification run 42599919808 dispatched)
- 42599919808 (failure: CMake 'No target JsonSchemaBuilder' bei $<TARGET_FILE:JsonSchemaBuilder>; FindJsonSchemaBuilder.cmake erstellt nur namespaced IMPORTED Target JsonSchemaBuilder::JsonSchemaBuilder, kein bare Alias; fixed by 0d955b4 Patch kodi-100.27 -> $<TARGET_FILE:JsonSchemaBuilder::JsonSchemaBuilder>, verification run 42615004151 in_progress)
- 42615004151 (completed failure: pack-skins 'TexturePacker::TexturePacker: Command not found', Error 127; fixed by 2227473 Patch kodi-100.28 -> \$<TARGET_FILE:TexturePacker::TexturePacker>, new verification run 42629418207 dispatched)
- 42629418207 (completed failure: TexturePacker als ARM-Binary cross-kompiliert, pack-skins 'Syntax error' auf x86_64-Builder; fixed by 800a5da TexturePacker:host + WITH_TEXTUREPACKER=$TOOLCHAIN/bin, new verification run 42641596480 dispatched at e9ad15c)
- 42641596480 (completed failure: TexturePacker:host cmake configure fails at find_package(Lzo2) — kodi's FindLzo2.cmake/FindGIF.cmake in cmake/modules not on standalone host build's CMAKE_MODULE_PATH; fixed by 2f987c8 PKG_CMAKE_OPTS_HOST += -DCMAKE_MODULE_PATH=$(get_build_dir $MEDIACENTER)/cmake/modules, new verification run 42658843775 dispatched at 2f987c8)
- 42658843775 (completed failure: TexturePacker:host add_executable 'No SOURCES given to target: TexturePacker' — '${CMAKE_SOURCE_DIR}/xbmc/guilib/XBTF.cpp' not found, paths relative to TexturePacker subdir instead of kodi root; fixed by kodi-100.29-fix-texturepacker-host-source-paths.patch (CMAKE_CURRENT_SOURCE_DIR/../../../../ = kodi root), verification dispatched after push)
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
- 42552793592 (failure at kodi source SHA256 mismatch; fixed by 0f8f77f, verification run 42563032671 dispatched)
