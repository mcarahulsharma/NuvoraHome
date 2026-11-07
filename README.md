# Nuvora Home — Samsung TV Launcher

A lightweight, remote-first home screen launcher for Samsung Tizen TVs.

## What it does
- Reads installed application information through the Samsung Tizen Application API.
- Displays installed apps in a clean, large-tile TV interface.
- Launches selected apps through `tizen.application.launch()`.
- Supports directional remote navigation and OK/Enter activation.
- Saves favourites locally on the TV.
- Includes a simple clock, date and settings panel.
- Contains no Home Assistant code, API tokens, dashboard widgets or device controls.

## Important Samsung TV limitation
Nuvora Home is a launcher-style application that you open from Samsung Apps. A regular third-party Tizen app cannot replace Samsung's built-in Home screen or guarantee that the physical Home button opens it. The Samsung system launcher remains in control of that button.

## Build and install
Every push to `main` runs the GitHub Actions Tizen WGT build and publishes the latest unsigned package as a GitHub Release asset. Install it using Apps2Samsung, which handles signing and sideloading.

- [Latest NuvoraHome.wgt](https://github.com/mcarahulsharma/NuvoraHome/releases/download/nuvorahome-latest/NuvoraHome.wgt)
- [Tizen build workflow](https://github.com/mcarahulsharma/NuvoraHome/actions/workflows/tizen-build.yml)

## API permissions
The Tizen app requests:
- `application.info` to enumerate installed applications.
- `application.launch` to start a selected application.
- `tv.inputdevice` for Samsung TV input-device access.

The launcher uses standard DOM keyboard events for directional navigation. If an installed app does not appear in the TV's application list or is not launchable by the platform, Nuvora cannot force it to appear or launch.

## Browser preview
A normal desktop or mobile browser does not expose the Samsung Tizen application manager. The app list and launching features therefore require the installed Tizen TV app runtime.