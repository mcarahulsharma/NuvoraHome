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
