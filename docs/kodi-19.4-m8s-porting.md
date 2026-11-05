# AlexELEC 3.3.3 -> Kodi 19.4 Matrix port (S812 M8S N200C 2G)

Branch: kodi-19.4-m8s, based on tag 3.3.3 (commit 23fd94bf02fc218df74a49ea649766ad96e53160).

## Existing architecture
- Amlogic vendor kernel 3.10.108, S812/Meson8m2, arm hard-float NEON, 32-bit.
- KODIPLAYER_DRIVER=libamcodec, CORE_PLATFORM_NAME=aml.
- DTB: meson8m2_n200C_2G.dtb (2GB memory reservations).
- libamcodec ARM32 from codesnake commit 5e23a81.
- RTL8723BS Wi-Fi + BT, RMII Ethernet, Mali-450.

## Migration strategy
- Stage A: inspect + document (this file).
- Stage B: unmodified baseline build via GitHub Actions (workflow build-m8s-kodi-19.yml).
- Stage C: Kodi 19.4 source (xbmc 19.4-Matrix), Python 3, amcodec integration.
- Stage D: workflow finalized.
- Stage E: image + update tarball + checksums.

## Known risks
- Amlogic amcodec integration not present upstream in Matrix; needs CoreELEC 19-era reference.
- Python 3.7.1 may be insufficient; verify Kodi 19.4 minimum.
- GitHub-hosted runner resource limits (disk/RAM).
