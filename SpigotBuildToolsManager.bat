@echo off
echo --------------------------------------------------------------
echo This tools will build the requested SpigotMC version
echo Any existing SpigotMC jars of the same version will be deleted
echo Leave requested version blank for the recommended build
echo WARNING: May fail if there are spaces in the working directory
echo --------------------------------------------------------------
set /p ver="Enter desired SpigotMC version: "
echo.
echo Attempting to build SpigotMC %ver%

rem Check if buildtools is accessable, if not -> download latest version
if exist BuildTools.jar (
    echo Using existing BuildTools.jar
) else (
    echo Downloading BuildTools.jar
    powershell -Command "Invoke-WebRequest https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar -OutFile BuildTools.jar"
    echo BuildTools.jar downloaded
)

rem If a conflicting spigot jar exists -> delete it
if exist spigot-%ver%.jar (
    rem file exists
    del spigot-%ver%.jar
    echo "Deleted existing Spigot jar."
) else (
    rem file doesn't exist
    echo "Existing Spigot jar not found."
)

rem If %ver% is set -> build that ver, else -> build default
echo Starting build
echo.
if [%ver%] == [] (
    java -jar BuildTools.jar
) else (
    java -jar BuildTools.jar --rev %ver%
)
pause
