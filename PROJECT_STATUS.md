Run 43553661064 (@ 03fc37f) completed failure. Neuer Root Cause: kodi-100.27 Patch-Kontext passt immer noch nicht zu Kodi 19.4 (Hunk #1 FAILED at 5 auf xbmc/interfaces/json-rpc/schema/CMakeLists.txt - Kontext erwartete 1 Leerzeichen/5-Zeilen-Hunk, Original hat 19-sp Einrueckung plus DEPENDS/COMMENT-Zeilen). CI-Log (job 132321532747) + kodi.log aus Artefakt build-logs-43553661064 geprueft.

Fix (Commit dd05c93, gepusht nach kodi-19.4-m8s): Patch-Kontext exakt an Kodi 19.4-Matrix angepasst (COMMAND-Zeile als Entfernung/Ersatz, 19-sp Einrueckung, @@ -7,5 Hunk), COMMAND -> \$<TARGET_FILE:JsonSchemaBuilder::JsonSchemaBuilder>. 'patch --dry-run' gegen originales Kodi 19.4 CMakeLists.txt erfolgreich. SHA256, Kodi-Version, Python, libamcodec, Kernel, M8S DTB unangetastet.

Neuer Verifikations-Run 43559248320 per gh workflow run bei dd05c93 ausgeloest (queued, https://github.com/neobonerific-ai/AE-AML/actions/runs/43559248320).

Bearbeitete Run-IDs: 43513092769, 43525636320, 43535794116, 43545689896, 43553661064 (alle completed failure, nicht mehrfach verarbeiten).

Nächster Schritt: Abwarten Run 43559248320 (keine weiteren Builds ausloesen solange er laeuft).
- Bei Erfolg: Baseline-Build durch -> PROJECT_STATUS.md aktualisieren -> Kodi 19.4 Matrix Port-Phase fortsetzen.
- Bei erneutem Fehler: Job-Log + Diagnose-Artefakte abrufen, Root Cause identifizieren, minimalen Fix committen/pushen, neuen Run dispatchen.
