@ECHO OFF
ECHO This will compile a Spigot jar for you. 
ECHO This will take 10 to 15 minutes depending on how your PC handles it.
ECHO There will be many lines of text. Don't worry, as it's all part of the process.
ECHO Continue?
PAUSE
:BuildTools
ECHO Downloading BuildTools...
ECHO.
MKDIR build
wget -O BuildTools.jar http://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar --no-check-certificate
MOVE BuildTools.jar build\BuildTools.jar
CLS
:DetectGit
ECHO Looking for Portable Git from last build....
ECHO.
IF EXIST portablegit GOTO askgit
GOTO Git
:askgit
ECHO The script has detected that you have built with this before and kept Git!
ECHO We can save some time and not go through the download process.
Choice /M "Do you want to skip over downloading Git?"
If Errorlevel 2 Goto Git
If Errorlevel 1 Goto askdifferentversion
ECHO.
:Git
wget -O PortableGit-1.9.5-preview20150319.7z https://github.com/msysgit/msysgit/releases/download/Git-1.9.5-preview20150319/PortableGit-1.9.5-preview20150319.7z --no-check-certificate
7za.exe x *.7z -oportablegit
:askdifferentversion
Choice /M "Do you want to build an alternate version of Spigot?"
If Errorlevel 2 Goto builddefault
If Errorlevel 1 CLS & Goto versionhelp
:versionhelp
ECHO Command guide:
ECHO STOPASKING - Stop asking for versions, goes back.
ECHO HELP - Show this guide again.
ECHO VERSIONLIST - Show a list of versions you can build.
ECHO.
ECHO These commands are case sensitive.
:versionask
set world=**noversionishere!!
set /P world=Enter version / command: 
IF %world% == STOPASKING GOTO askdifferentversion
IF %world% == HELP GOTO versionhelp
IF %world% == VERSIONLIST GOTO versionlist
IF %world% == **noversionishere!! ECHO Please put in a version name. & GOTO versionask
IF %world% == default ECHO Now will complile with the default settings & GOTO builddefault
IF %world% == 1.8.0 ECHO Now will complile 1.8.0 & GOTO build180
IF %world% == 1.8.4 ECHO Now will complile 1.8.4 & GOTO build184
IF %world% == 1.8.5 ECHO Now will complile 1.8.5 & GOTO build185
ECHO Please input a valid version name.
GOTO versionask
:versionlist
ECHO.
ECHO default
ECHO 1.8.0
ECHO 1.8.4
ECHO 1.8.5
ECHO.
GOTO versionask
:builddefault
cmd.exe /c ""portablegit\bin\sh.exe" --login -i -- builder.sh"
GOTO afterbuild
:build180
cmd.exe /c ""portablegit\bin\sh.exe" --login -i -- builder180.sh"
GOTO afterbuild
:build184
cmd.exe /c ""portablegit\bin\sh.exe" --login -i -- builder184.sh"
GOTO afterbuild
:build185
cmd.exe /c ""portablegit\bin\sh.exe" --login -i -- builder185.sh"
GOTO afterbuild
:afterbuild
XCOPY build\Spigot\Spigot-Server\target\*.jar *.jar /Y /EXCLUDE:excludelist.txt
IF EXIST *.jar GOTO compiled
IF NOT EXIST *.jar GOTO didnotcompile
:didnotcompile
ECHO.
ECHO It appears the script didn't build correctly!
ECHO Check out what happened above.
ECHO If it's my fault, create an issue on my GitHub repo
PAUSE
GOTO askgitkeep
:compiled
CLS
ECHO The spigot build has been built and put into the same folder as your %~nx0 file.
ECHO The Spigot build has been saved to:
    for %%f in (*.jar) do (

            set jarfile=%%~nf.jar
    )
set foldername=%~dp0
echo.%foldername%%jarfile%
ECHO.
:askgitkeep
Choice /M "Keep Git? This will speed up the next time you build with this script."
If Errorlevel 2 RD /S /Q portablegit
If Errorlevel 1 Goto askcleanup
:askcleanup
ECHO.
Choice /M "Clean up files generated / downloaded? (If in doubt, say yes.)"
If Errorlevel 2 Goto done
If Errorlevel 1 Goto cleanup
:cleanup
DEL /Q *.7z
RD /S /Q build
:done
ECHO Done!
PAUSE