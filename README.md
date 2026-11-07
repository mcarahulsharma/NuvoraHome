# Nuvora Home

A cinematic, remote-friendly Home Assistant control centre designed for a Samsung QLED TV and other large screens.

## Features
- Big-screen responsive interface with keyboard / TV remote focus support.
- Direct Home Assistant REST API and WebSocket state updates.
- Local browser storage for the Home Assistant URL and long-lived access token.
- Controls for climate entities, Godrej AC fan, lights/switches, media players and AQI.
- PWA manifest and offline app-shell caching.
- GitHub Actions deployment to GitHub Pages.

## Deploy
1. Open **Settings → Pages** in this repository.
2. Set **Source** to **GitHub Actions**.
3. The workflow deploys automatically on pushes to `main`.
4. Open the Pages URL shown in the Pages settings.

## Connect Home Assistant
1. Open the app, select **Home Assistant settings**.
2. Enter your Home Assistant base URL (for example `http://192.168.29.17:8123`) and a Long-Lived Access Token.
3. The token is stored only in this browser's local storage and sent directly to your Home Assistant instance.

Your browser/TV must be able to reach Home Assistant over the network. If the dashboard is served over HTTPS, browsers may block an HTTP Home Assistant endpoint as mixed content; use a trusted HTTPS Home Assistant URL or a same-network reverse proxy with HTTPS.

## Current entity profile
The initial dashboard recognises the entities supplied for this home:
- `climate.godrej_ac`, `climate.bedroom_ac`, `climate.fridge_thermostat`
- `fan.godrej_ac`
- `switch.tapo_plug_2`, `switch.bedroom_light_sensor`
- `light.stairway_floodlight_timed`
- `media_player.samtv`, `media_player.50_qled`, `media_player.rahul_tv_qa50q7faaulxl`, `media_player.jio_set_top_box`
- `sensor.outdoor_derawal_nagar_aqi_india`

The dashboard displays entities only after Home Assistant returns their states. It does not embed streaming services; media controls operate through Home Assistant integrations.

## Security
Do not put access tokens in source files, issues, screenshots or commits. Use a dedicated Home Assistant token and revoke it in Home Assistant if the TV/browser is lost or retired.

## Samsung TV note
This first release is a web app intended to be opened in the TV's browser. A native Samsung Tizen `.wgt` package requires a Tizen TV certificate/profile and device-specific installation/signing; GitHub Pages alone does not install a native TV app.


## Samsung TV and Home Assistant networking

The GitHub Pages copy is delivered over HTTPS. Modern browsers can block requests from that HTTPS page to a plain HTTP Home Assistant URL on your LAN (mixed content). For a local-only Home Assistant installation such as `http://192.168.29.17:8123`, the most reliable browser test is to serve the app from Home Assistant itself:

1. Copy the app files (`index.html`, `manifest.webmanifest`, `sw.js`, and `icon.svg`) into `/config/www/nuvora-home/`.
2. Open `http://192.168.29.17:8123/local/nuvora-home/` on the TV browser.
3. In Nuvora settings, use the same Home Assistant address: `http://192.168.29.17:8123`.

This makes the dashboard and API same-origin, avoiding the HTTPS-to-HTTP browser restriction and separate CORS setup. If you prefer the GitHub Pages URL, use a trusted HTTPS address for Home Assistant and allow the Pages origin in Home Assistant's `http.cors_allowed_origins` configuration. Merge that setting into any existing `http:` section; do not create a duplicate YAML key.

## Six TV views
- **Overview** — household status and air quality.
- **Climate** — ACs and fan controls.
- **Lighting** — smart plugs, switches and lights.
- **Entertainment** — Samsung TVs and Jio set-top box.
- **Environment** — discovered AQI, temperature and humidity sensors.
- **Settings** — Home Assistant connection.

The app discovers additional climate, fan, light, switch, media-player and selected environmental sensor entities returned by Home Assistant. The initial list provides friendly labels for the devices you shared.


## One-tap-ish Samsung TV installation using Apps2Samsung (no Tizen Studio)

Every push to `main` runs the Tizen WGT build workflow and publishes/replaces the latest package at the GitHub Release tag `nuvorahome-latest`.

- Latest WGT: [NuvoraHome.wgt](https://github.com/mcarahulsharma/NuvoraHome/releases/download/nuvorahome-latest/NuvoraHome.wgt)
- Build workflow: [Tizen WGT build](https://github.com/mcarahulsharma/NuvoraHome/actions/workflows/tizen-build.yml)

### Install from an Android phone

1. Install Apps2Samsung from its official [GitHub releases](https://github.com/Apps2Samsung/Apps2Samsung/releases) or add its F-Droid repository: `https://apps2samsung.com/fdroid/repo`.
2. On the Samsung TV, open Apps, enter `12345` with the remote, enable Developer Mode, and set Host PC IP to the phone's current Wi-Fi IPv4 address. Restart the TV.
3. Connect the phone to the same Wi-Fi network and open Apps2Samsung.
4. Select the TV. On first use, Apps2Samsung guides you through Samsung sign-in and creates the signing certificate. The app reuses that certificate for later installs.
5. Choose the custom WGT option and use the latest WGT download above (download it to the phone first if the app asks for a local file).
6. Install and launch Nuvora Home.

The WGT built by GitHub is intentionally unsigned. Apps2Samsung signs it for your TV using its certificate flow. Do not upload private certificate files to this repository.

### Home Assistant connection

For the first reliable test, serve the app from Home Assistant's `/local/nuvora-home/` folder so the app and Home Assistant API share the same origin. GitHub Pages is useful for the public project and source, but its HTTPS page may be blocked from calling a plain HTTP LAN Home Assistant URL by browser mixed-content rules.

**Note:** Apps2Samsung requires Developer Mode for sideload installation. Its phone app handles the signing/install workflow; it does not remove Samsung's Developer Mode requirement.
