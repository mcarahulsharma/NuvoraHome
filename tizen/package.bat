@echo off
setlocal
if "%TIZEN_PROFILE%"=="" (
  echo Set TIZEN_PROFILE to your active Samsung TV certificate profile name.
  echo Create a certificate profile in Tizen Studio Certificate Manager first.
  exit /b 1
)
where tizen >nul 2>nul
if errorlevel 1 (
  echo Tizen CLI not found. Install Tizen Studio with Web CLI and Samsung TV Extensions.
  exit /b 1
)
cd /d "%~dp0.."
tizen build-web -- .
if errorlevel 1 exit /b 1
tizen package -t wgt -s "%TIZEN_PROFILE%" -- .buildResult
if errorlevel 1 exit /b 1
echo Search .buildResult for the generated .wgt package.
endlocal
