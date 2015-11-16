@ECHO OFF
:afterbuild
XCOPY buildfiles\build\Spigot\Spigot-Server\target\*.jar *.jar /Y /EXCLUDE:buildfiles\excludelist.txt
IF EXIST *.jar GOTO compiled
IF NOT EXIST *.jar GOTO didnotcompile
:didnotcompile
ECHO.
ECHO It appears the script didn't build correctly!
ECHO Check out what happened above.
ECHO If it's my fault, create an issue on my GitHub repo.
ECHO github.com/colebob9/spigotbuilder
ECHO.
PAUSE
GOTO askgitkeep
:compiled
CLS
    for %%f in (*.bat) do (

            set batfile=%%~nf.bat
    )
ECHO The spigot build has been built and put into the same folder as your 
ECHO %batfile% file.
ECHO.
ECHO The Spigot build has been saved to:
    for %%f in (*.jar) do (

            set jarfile=%%~nf.jar
    )
set foldername=%~dp0
echo.%foldername%%jarfile%
ECHO.
:askgitkeep
Choice /M "Keep Git? This will speed up the next time you build with this script."
If Errorlevel 2 RD /S /Q buildfiles\portablegit
If Errorlevel 1 Goto askcleanup
:askcleanup
ECHO.
Choice /M "Clean up files generated / downloaded? (If in doubt, say yes.)"
If Errorlevel 2 Goto done
If Errorlevel 1 Goto cleanup
:cleanup
DEL /Q buildfiles\*.7z
RD /S /Q buildfiles\build
:done
ECHO.
ECHO Done!
PAUSE