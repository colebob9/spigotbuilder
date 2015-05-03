@ECHO OFF
ECHO This will compile a spigot jar for you. 
ECHO This will take 10 to 15 minutes depending on how your PC handles it.
ECHO There will be many lines of text. Don't worry, as it's all part of the process.
ECHO Continue?
PAUSE
:Git
wget -O PortableGit-1.9.5-preview20150319.7z https://github.com/msysgit/msysgit/releases/download/Git-1.9.5-preview20150319/PortableGit-1.9.5-preview20150319.7z --no-check-certificate
7za.exe x *.7z -oportablegit
:build
MKDIR build
wget -O BuildTools.jar http://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar --no-check-certificate
MOVE BuildTools.jar build\BuildTools.jar
cmd.exe /c ""portablegit\bin\sh.exe" --login -i -- builder.sh"
XCOPY build\Spigot\Spigot-Server\target\*.jar *.jar /Y /EXCLUDE:excludelist.txt
CLS
ECHO The spigot build has been built and put into the same folder as your %~nx0 file.
ECHO The Spigot build has been saved to:
    for %%f in (*.jar) do (

            set jarfile=%%~nf.jar
    )
set foldername=%~dp0
echo.%foldername%%jarfile%
ECHO.
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