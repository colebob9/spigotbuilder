@ECHO OFF
ECHO This will compile a spigot jar for you. 
ECHO This will take 10 to 15 minutes depending on how your PC handles it.
ECHO Continue?
PAUSE
ECHO The script can download Git as it is required for building Spigot.
ECHO If you do not have Git installed, the build will not work properly.
Choice /M "Do you already have Git installed on your computer?"
If Errorlevel 2 Goto Git
If Errorlevel 1 Goto build
:Git
ECHO Make sure to allow the Git installer to make changes to your PC. (Allow UAC)
PAUSE
wget -O Git-1.9.5-preview20150319.exe https://github.com/msysgit/msysgit/releases/download/Git-1.9.5-preview20150319/Git-1.9.5-preview20150319.exe --no-check-certificate
Git-1.9.5-preview20150319.exe
Choice /M "Did Git install properly?"
If Errorlevel 2 Goto githelp
If Errorlevel 1 Goto cleangit
:githelp
DEL Git-1.9.5-preview20150319.exe
ECHO The script will now redownload Git.
PAUSE
GOTO Git
:cleangit
DEL Git-1.9.5-preview20150319.exe
:build
MKDIR build
wget -O BuildTools.jar http://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar --no-check-certificate
MOVE BuildTools.jar build\BuildTools.jar
builder.sh
PAUSE