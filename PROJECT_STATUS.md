Run 43553661064 (@ 03fc37f) completed failure. Neuer Root Cause: kodi-100.27 Patch-Kontext passt immer noch nicht zu Kodi 19.4 (Hunk #1 FAILED at 5 auf xbmc/interfaces/json-rpc/schema/CMakeLists.txt - Kontext erwartete 1 Leerzeichen/5-Zeilen-Hunk, Original hat 19-sp Einrueckung plus DEPENDS/COMMENT-Zeilen). CI-Log (job 132321532747) + kodi.log aus Artefakt build-logs-43553661064 geprueft.

Fix (Commit dd05c93, gepusht nach kodi-19.4-m8s): Patch-Kontext exakt an Kodi 19.4-Matrix angepasst (COMMAND-Zeile als Entfernung/Ersatz, 19-sp Einrueckung, @@ -7,5 Hunk), COMMAND -> \$<TARGET_FILE:JsonSchemaBuilder::JsonSchemaBuilder>. 'patch --dry-run' gegen originales Kodi 19.4 CMakeLists.txt erfolgreich. SHA256, Kodi-Version, Python, libamcodec, Kernel, M8S DTB unangetastet.

Run 43559248320 (@ dd05c93) completed failure. Neuer Root Cause: kodi-zfork-004-keyboard_xml-kbd_layout.patch passt nicht zu Kodi 19.4 (Hunk #1 FAILED at 172 auf system/keymaps/keyboard.xml - Kodi 19.4 Commit e12e66e0 hat eine zusatzliche Zeile <f11>HDRToggle</f11> zwischen </r> und </keyboard>, das alte Patch-Kontext passt nicht mehr). CI-Log (job 132339032090) + kodi.log aus Artefakt build-logs-43559248320 geprueft. Lokaal nachgestellt gegen originales Kodi 19.4-Quelltext (xbmc/xbmc e12e66e019af29ba9d5f5a2614315b15a138b81a).

Fix (Commit 7999cab, gepusht nach kodi-19.4-m8s, neuer CI-Run per Push ausgeloest): Patch-Kontext exakt an Kodi 19.4 angepasst (<f11>HDRToggle</f11> in Kontext aufgenommen, eingefuegte Zeile <escape mod="ctrl">RunAddon(script.key.layout)</escape> unveraendert). Kontext-Abgleich gegen originales Kodi 19.4-Quelltext erfolgreich. SHA256, Kodi-Version, Python, libamcodec, Kernel, M8S DTB unangetastet.

Bearbeitete Run-IDs: 43513092769, 43525636320, 43535794116, 43545689896, 43553661064, 43559248320 (alle completed failure, nicht mehrfach verarbeiten).

Nächster Schritt: Abwarten des neuen CI-Runs bei 7999cab (per Push ausgeloest, Run-ID steht noch nicht fest und wird im nächsten Cron-Lauf erfasst).
- Bei Erfolg: Baseline-Build durch -> PROJECT_STATUS.md aktualisieren -> Kodi 19.4 Matrix Port-Phase fortsetzen.
- Bei erneutem Fehler: Job-Log + Diagnose-Artefakte abrufen, Root Cause identifizieren, minimalen Fix committen/pushen.
