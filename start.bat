@ECHO OFF
TITLE SpigotBuilder v1.2
ECHO SpigotBuilder v1.2
ECHO Developed by colebob9!
ECHO Source: github.com/colebob9/spigotbuilder
ECHO Licenced under the MIT license.
ECHO.
ECHO This will compile a Spigot server jar for you.
ECHO The process will take about 10 to 15 minutes, depending on how your PC 
ECHO handles it.
ECHO Many lines of text will display on screen, showing the progress of the script.
ECHO Don't worry, as it's all part of the process of building Spigot.
ECHO.
PAUSE
:BuildTools
ECHO.
ECHO Downloading BuildTools...
ECHO.
MKDIR buildfiles\build
cmd /C buildfiles\wget.exe -O buildfiles\build\BuildTools.jar http://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar --no-check-certificate
TITLE SpigotBuilder v1.2
CLS
:DetectGit
ECHO Looking for Portable Git from last build....
ECHO.
IF EXIST buildfiles\portablegit GOTO askgit
GOTO Git
:askgit
ECHO The script has detected that you have built with this before and kept Git!
ECHO We can save some time and not go through the download process.
Choice /M "Do you want to skip downloading Git?"
If Errorlevel 2 Goto Git
If Errorlevel 1 Goto askdifferentversion
ECHO.
:Git
ECHO.
ECHO Downloading Portable Git...
ECHO.
buildfiles\wget.exe -O buildfiles\PortableGit-1.9.5-preview20150319.7z https://github.com/msysgit/msysgit/releases/download/Git-1.9.5-preview20150319/PortableGit-1.9.5-preview20150319.7z --no-check-certificate
TITLE SpigotBuilder v1.2
buildfiles\7za.exe x buildfiles\*.7z -obuildfiles\portablegit
CLS
:askdifferentversion
ECHO.
Choice /M "Do you want to build an alternate version of Spigot?"
If Errorlevel 2 Goto builddefault
If Errorlevel 1 CLS & buildfiles\versioncheck.bat
:builddefault
cd buildfiles
cmd.exe /c ""portablegit\bin\sh.exe" --login -i -- builder.sh"
GOTO afterbuild
:afterbuild
afterbuild.bat