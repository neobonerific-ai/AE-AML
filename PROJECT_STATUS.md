# Project Status

## Phase
Baseline build (AlexELEC 3.3.3 S812/M8S) in progress.

## Last Run
Run ID: 42125755256 completed failure at 1c3ac55 (cpio:host multiple definition program_name). Fixed by 53b9081 (CFLAGS=-fcommon). New run pending.
Commit SHA: 53b9081 (latest)
Status: pushed; awaiting next run. No workflow_dispatch.

## Fixes Applied
- Host deps xfonts-utils, libxml-parser-perl
- make:host __stat (CFLAGS -D__stat=stat)
- m4:host SIGSTKSZ patch (0003-c-stack-stop-using-SIGSTKSZ.patch)
- linux:host full commit SHA + verified SHA256
- binutils gold missing <string> include
- binutils gold narrowing conversion (pr_type)
- binutils gold patch: correct hunk headers and context
- Workflow: concurrency, diagnostic logs, output verification, log filename sanitization
- libcap:host URL (kernel.org 404 → mirrors.edge.kernel.org)
- fakeroot:host _STAT_VER=0 for modern glibc
- nss:host disable return-local-addr error (modern gcc)

## Open Tasks
- Monitor current run (push from 186c0e8); identify next failure if any.
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
- 42100301559 (failure, fixed by b2b847d - squashfs -fcommon)
