@ECHO OFF
TITLE SpigotBuilder v1.2
:filecheck
ECHO Checking for required files before starting....
ECHO.
IF NOT EXIST buildfiles\wget.exe ECHO wget.exe could not be found! Please download a new release to fix this. & GOTO filewarning
IF NOT EXIST buildfiles\7za.exe ECHO 7za.exe could not be found! Please download a new release to fix this. & GOTO filewarning
IF NOT EXIST buildfiles\versioncheck.bat ECHO versioncheck.bat could not be found! Please download a new release to fix this. & GOTO filewarning
IF NOT EXIST buildfiles\afterbuild.bat ECHO afterbuild.bat could not be found! Please download a new release to fix this. & GOTO filewarning
IF NOT EXIST buildfiles\builder.sh ECHO builder.sh could not be found! Please download a new release to fix this. & GOTO filewarning
IF NOT EXIST buildfiles\libeay32.dll ECHO libeay32.dll could not be found! Please download a new release to fix this. & GOTO filewarning
IF NOT EXIST buildfiles\libiconv2.dll ECHO libiconv2.dll could not be found! Please download a new release to fix this. & GOTO filewarning
IF NOT EXIST buildfiles\libintl3.dll ECHO libintl3.dll could not be found! Please download a new release to fix this. & GOTO filewarning
IF NOT EXIST buildfiles\libssl32.dll ECHO libssl32.dll could not be found! Please download a new release to fix this. & GOTO filewarning
IF NOT EXIST buildfiles\excludelist.txt ECHO excludelist.txt could not be found! Please download a new release to fix this. & GOTO filewarning
GOTO start
:filewarning
ECHO.
PAUSE
EXIT
:start
CLS
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
IF EXIST buildfiles\portablegit ECHO Found! & ECHO. & GOTO askgit
ECHO. & GOTO Git & ECHO Not found.
:askgit
ECHO We detected that you've built with this before and kept Git!
ECHO We can save a ton of time by skipping the download and extracting process.
ECHO.
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