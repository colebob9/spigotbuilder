@ECHO off
Choice /M "Clean up files generated / downloaded? (If in doubt, say yes.)"
If Errorlevel 2 Goto done
If Errorlevel 1 Goto cleanup
:cleanup
DEL /Q *.7z
RD /S /Q portablegit
RD /S /Q build
:done
ECHO Done!
PAUSE