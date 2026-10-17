---
name: sps-nest-schedule
description: Program official Google Nest Thermostat schedules natively via Android ADB automation.
---

# Google Nest Thermostat Schedule Automation via Android ADB

This skill provides complete operational knowledge and precise automation instructions for driving the official Google Nest Android application (`com.nest.android`) via ADB (Android Debug Bridge) wireless debugging to program thermostat heating schedules directly on physical Nest hardware.

---

## 1. Motivation & Architecture

### Why Native App Automation?
* **Zero Cloud Developer Fees ($0)**: Google charges a one-time $5 fee per Google Account for the Google Cloud Device Access Console (Smart Device Management API), which additionally suffers from rate-limits and OAuth token refresh deprecations.
* **Family-Friendly & Native**: Schedules programmed directly into the Nest app sync directly to the physical thermostats and cloud profile. Spouses and family members can view schedules, turn physical thermostat dials, or use the official Nest/Google Home apps without needing Home Assistant or technical knowledge.
* **Rock-Solid Hardware Autonomy**: Thermostats run their internal schedules even if local Wi-Fi, Home Assistant, or home automation servers drop offline.

---

## 2. Android Device Connectivity (Wireless Debugging)

### A. Pairing vs. Connecting
Android Developer Options separates **Pairing** from **Connecting**:
1. **Pairing (One-Time)**:
   * On phone: **Developer Options > Wireless debugging > Pair device with pairing code**.
   * Note the IP, pairing port (e.g. `46337`), and 6-digit code (e.g. `851627`).
   * Command:
     ```bash
     adb pair <IP>:<pairing_port> <pairing_code>
     ```
2. **Connecting (Persistent)**:
   * Once paired, the dialog closes. The main Wireless debugging screen displays a **different** port under **"IP address & Port"** (e.g. `39911`).
   * Command:
     ```bash
     adb connect <IP>:<connect_port>
     ```

### B. Auto-Discovery Helper (Python)
If Android reconnects to Wi-Fi and port changes, scan open high ports with asyncio:
```python
import asyncio

async def check_port(ip, port):
    try:
        conn = asyncio.open_connection(ip, port)
        reader, writer = await asyncio.wait_for(conn, timeout=0.15)
        writer.close()
        await writer.wait_closed()
        return port
    except:
        return None

async def scan(ip="192.168.1.224", start=30000, end=50000):
    tasks = [check_port(ip, p) for p in range(start, end)]
    for chunk in [tasks[i:i+2000] for i in range(0, len(tasks), 2000)]:
        res = await asyncio.gather(*chunk)
        for p in res:
            if p: print(f"Open port found: {p}")

asyncio.run(scan())
```

---

## 3. Nest App Navigation & Orientation

* **Package**: `com.nest.android`
* **Activities**:
  * Home Screen / Thermostat Overview: `com.obsidian.v4.activity.HomeActivity` (Portrait `1080x2424`).
  * Schedule Grid: `com.obsidian.v4.activity.ScheduleActivity` (Landscape `2424x1080`).

```bash
# Launch Nest App
adb -s <DEVICE> shell monkey -p com.nest.android -c android.intent.category.LAUNCHER 1
```

---

## 4. Critical Pre-Step: Disabling Auto-Schedule

> [!CAUTION]
> **You MUST disable Auto-Schedule** on every thermostat before setting custom schedules. Otherwise, Nest Sense will continuously rewrite your custom schedule whenever someone touches the dial.

1. In `HomeActivity`, tap target Thermostat puck (e.g. `x=540, y=1080` for center).
2. Tap the **Settings (Gear)** icon at top right:
   * Bounds: `[978, 219][1033, 272]`, Center: `(1005, 245)`.
3. Tap **Auto-Schedule** row:
   * Resource ID: `com.nest.android:id/setting_auto_schedule`
   * Bounds: `[0, 593][1080, 761]`, Center: `(540, 677)`.
4. Tap the toggle switch:
   * Resource ID: `com.nest.android:id/setting_auto_schedule_switch`
   * Center: `(935, 1036)`.
5. Tap **OK** on the confirmation dialog ("Turn off Auto-Schedule?"):
   * Resource ID: `android:id/button1`
   * Bounds: `[810, 1454][978, 1596]`, Center: `(894, 1525)`.
6. Tap **Back** icon (`73, 246`) to return to thermostat view.

---

## 5. ScheduleActivity Mechanics (Landscape 2424x1080)

To open the schedule, tap the **SCHEDULE** icon at the bottom of the thermostat view (`675, 2300`). The phone automatically flips to landscape (`2424x1080`).

### A. Coordinate System

#### 1. X-Axis (Time Timeline)
* Total timeline width: from $x \approx 173$ ($00:00$) to $x \approx 2424$ ($24:00$).
* Formula:
  $$\text{X} = 173 + (\text{Hours} \times 94.625)$$
* Quick Reference:
  * `00:15`: $x = 197$
  * `05:30`: $x = 693$
  * `06:30`: $x = 788$
  * `07:30`: $x = 883$
  * `11:30`: $x = 1261$
  * `13:30`: $x = 1450$
  * `15:45`: $x = 1664$
  * `20:30`: $x = 2112$
  * `21:30`: $x = 2207$
  * `23:00`: $x = 2349$

#### 2. Y-Axis (Temperature)
* Higher temperature is **UP** (lower $y$ value).
* Scale: $\approx 17\text{ pixels}$ per $1.0^\circ\text{C}$ (or $\approx 8.5\text{ px}$ per $0.5^\circ\text{C}$).
* Reference targets:
  * $22.0^\circ\text{C}$: $y \approx 460 - 515$
  * $21.0^\circ\text{C}$: $y \approx 490 - 530$
  * $20.0^\circ\text{C}$: $y \approx 530 - 550$
  * $19.5^\circ\text{C}$: $y \approx 550 - 560$
  * $19.0^\circ\text{C}$: $y \approx 560 - 580$

---

### B. Adding and Adjusting Setpoints

1. **Enter Day Zoom View**: Tap anywhere on the day row (e.g. Monday $x=500, y=237$).
2. **Add Point**:
   * Tap **Add** button at bottom right: `[1993, 902][2140, 1006]`, Center `(2066, 954)`.
   * Tap on the grid at desired $(X, Y)$ coordinate.
3. **Verify Position**:
   * Dump UI hierarchy:
     ```bash
     adb shell uiautomator dump /sdcard/dump.xml && adb pull /sdcard/dump.xml /tmp/dump.xml
     ```
   * Parse node ID:
     `com.nest.android:id/schedule_window_heat_set_point:(<Day>, <Time>):<Temp>`
4. **Fine-Tuning**:
   * **Temperature**: Drag center vertically:
     * Raise $1.0^\circ\text{C}$: `adb shell input swipe X Y X (Y - 17) 300`
     * Lower $1.0^\circ\text{C}$: `adb shell input swipe X Y X (Y + 17) 300`
   * **Time**: Drag center horizontally:
     * Advance 15m (+24px): `adb shell input swipe X Y (X + 24) Y 400`
     * Delay 15m (-24px): `adb shell input swipe X Y (X - 24) Y 400`
5. **Removing Setpoint**:
   * Tap **Remove** button: `[2172, 902][2392, 1006]`, Center `(2282, 954)`.
   * Tap directly on the setpoint dot to delete it.

---

## 6. The Day Copy/Paste/Clear Discovery

In the 7-day overview screen, you do **not** need to manually tap out every day. The Nest app has a hidden context menu:

### A. Day Row Y-Coordinates (7-Day Overview)
* **Monday**: Center $y = 237$ (`bounds=[173,189][388,286]`)
* **Tuesday**: Center $y = 334$ (`bounds=[173,286][388,383]`)
* **Wednesday**: Center $y = 431$ (`bounds=[173,383][388,480]`)
* **Thursday**: Center $y = 528$ (`bounds=[173,480][388,577]`)
* **Friday**: Center $y = 625$ (`bounds=[173,577][388,673]`)
* **Saturday**: Center $y = 721$ (`bounds=[173,673][388,769]`)
* **Sunday**: Center $y = 817$ (`bounds=[173,769][388,865]`)

### B. Fast Workflow
1. **Long-Press Source Day**:
   * Long-press in the middle of Monday ($x=1200, y=237$) for 1200ms:
     ```bash
     adb shell input swipe 1200 237 1200 237 1200
     ```
2. **Tap Copy**:
   * Popup appears with `Copy` (`[204, 297][388, 422]`, center `(296, 359)`).
3. **Paste to Target Days**:
   * Long-press Tuesday ($x=1200, y=334$ for 1200ms).
   * Tap `Paste` (`[388, 152][587, 277]`, center `(487, 214)`).
   * Repeat for Wednesday ($y=431$, paste `(487, 311)`), Thursday ($y=528$, paste `(487, 408)`), etc.
4. **Clear Day**:
   * To start fresh on any day, long-press the row and tap `Clear day` (`[587, 297][867, 422]`, center `(727, 359)`).

---

## 7. Verification Script

Verify all setpoints programmatically after setting:

```python
import xml.etree.ElementTree as ET

def verify_schedule(xml_path):
    tree = ET.parse(xml_path)
    for node in tree.iter("node"):
        res_id = node.attrib.get("resource-id", "")
        desc = node.attrib.get("content-desc", "")
        if "set_point" in res_id:
            print(f"✅ {desc}")

verify_schedule("/tmp/kids_full.xml")
```
