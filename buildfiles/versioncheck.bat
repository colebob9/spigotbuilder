@ECHO OFF
:versionhelp
ECHO Command guide:
ECHO HELP - Show this guide again.
ECHO VERSIONLIST - Show a list of versions you can build.
ECHO.
ECHO These commands are case sensitive.
:versionask
set version=**noversionishere!!
set /P version=Enter version / command: 
IF %version% == HELP ECHO. & GOTO versionhelp
IF %version% == VERSIONLIST GOTO versionlist
IF %version% == **noversionishere!! ECHO. & ECHO Please put in a version name. & ECHO. & GOTO versionask
IF %version% == latest ECHO Now will complile the latest version with the default settings & GOTO builddefault
IF %version% == 1.8.0 ECHO Now will complile 1.8.0 & GOTO build180
IF %version% == 1.8.3 ECHO Now will complile 1.8.3 & GOTO build183
IF %version% == 1.8.4 ECHO Now will complile 1.8.4 & GOTO build184
IF %version% == 1.8.5 ECHO Now will complile 1.8.5 & GOTO build185
IF %version% == custom GOTO customversionhelp
IF %version% == dev ECHO SKIPPING BUILD & GOTO afterbuild
ECHO.
ECHO Please input a valid version name. Type VERSIONLIST for options.
ECHO.
GOTO versionask
:versionlist
ECHO.
ECHO latest (Always use this if in doubt.)
ECHO 1.8.0
ECHO 1.8.3
ECHO 1.8.4
ECHO 1.8.5
ECHO custom (ADVANCED, ONLY USE IF YOU KNOW WHAT THIS DOES!)
ECHO.
GOTO versionask
:customversionhelp
ECHO.
ECHO You have entered custom mode.
ECHO THIS CAN BREAK THE SCRIPT AND WILL MAY REQUIRE YOU TO RESTART
ECHO To go back to the easier version selector, type GOBACK
ECHO To show this screen again, type HELP
ECHO.
ECHO Type the version as you would after the "--rev" flag in BuildTools.
ECHO Example: Enter custom version: 1.8.3
:customversionask
set customversion=**nocustomversionishere!!
set /P customversion=Enter custom version / command: 
IF %customversion% == HELP ECHO. & GOTO customversionhelp
IF %customversion% == GOBACK ECHO. & CLS & GOTO versionhelp
IF %customversion% == **nocustomversionishere!! ECHO Type a valid version name. & GOTO customversionask 
ECHO #!/bin/sh >> %customversion%builder.sh
ECHO echo Starting custom build process! >> %customversion%builder.sh
ECHO cd build >> %customversion%builder.sh
ECHO java -jar BuildTools.jar --rev %customversion% >> %customversion%builder.sh
ECHO Created custom build file! Starting...
GOTO buildcustom
:builddefault
cmd.exe /c ""buildfiles\portablegit\bin\sh.exe" --login -i -- buildfiles\builder.sh"
GOTO afterbuild
:build180
cmd.exe /c ""buildfiles\portablegit\bin\sh.exe" --login -i -- buildfiles\builder180.sh"
GOTO afterbuild
:build183
cmd.exe /c ""buildfiles\portablegit\bin\sh.exe" --login -i -- buildfiles\builder183.sh"
GOTO afterbuild
:build184
cmd.exe /c ""buildfiles\portablegit\bin\sh.exe" --login -i -- buildfiles\builder184.sh"
GOTO afterbuild
:build185
cmd.exe /c ""buildfiles\portablegit\bin\sh.exe" --login -i -- buildfiles\builder185.sh"
GOTO afterbuild
:buildcustom
cmd.exe /c ""buildfiles\portablegit\bin\sh.exe" --login -i -- buildfiles\%customversion%builder.sh"
GOTO afterbuild
:afterbuild
afterbuild.bat