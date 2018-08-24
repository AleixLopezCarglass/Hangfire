@echo off
.nuget\NuGet.exe install .nuget\packages.config -OutputDirectory packages -Verbosity normal
choco install "sonarscanner-msbuild-net46" -y
choco install "sonarscanner-msbuild-netcoreapp2.0" -y
SonarScanner.MSBuild.exe begin /k:"HangFireFork" /d:sonar.organization="aleixlopezcarglass-github" /d:sonar.host.url="https://sonarcloud.io" /d:sonar.login="4e0a76ecad19028340d48e2d603b9208eef8e4de"
powershell.exe -NoProfile -ExecutionPolicy unrestricted -Command "& {Import-Module '.\packages\psake.*\tools\psake.psm1'; invoke-psake .\psake-project.ps1 %*; if ($LastExitCode -and $LastExitCode -ne 0) {write-host "ERROR CODE: $LastExitCode" -fore RED; exit $lastexitcode} }"
SonarScanner.MSBuild.exe end
