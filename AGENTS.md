# AE-AML Agent Instructions

## Mission
Build unmodified AlexELEC 3.3.3 S812/M8S baseline image via GitHub Actions on branch kodi-19.4-m8s. Only after baseline success start Kodi 19.4 Matrix port.

## Environment
- Repo: /root/AE-AML
- Branch: kodi-19.4-m8s
- Target: PROJECT=S812 DEVICE=M8S ARCH=arm
- Build: ./scripts/image_mt_ae mkimage

## Rules
- Do not modify Kodi version, Python packages, libamcodec, kernel, M8S DTB, Wi-Fi/BT/Ethernet, CPU config, Amlogic drivers.
- Never disable SHA256 verification.
- Never run internal NAND/eMMC flash.
- Fix only proven root causes, minimal changes.
- Preserve existing working patches.
- Keep branch isolated.
