# get_externalconnections
Logs active external TCP connections with GeoIP lookup and outputs to a file.

# 🛰 External Connection Logger with GeoIP Lookup

A PowerShell script that identifies active **external TCP connections** to your Windows system, enriches them with **GeoIP data**, and logs the results to a file. Designed for advanced threat hunting and situational awareness, especially in environments where stealthy connections may go unnoticed.

## 📌 Features

- Lists active non-local TCP connections
- Filters out private/local IP addresses (loopback and RFC1918 ranges)
- Integrates with [ip-api.com](http://ip-api.com) to perform live GeoIP lookups
- Logs connection metadata with location context to a timestamped file
- Displays results in a clean, formatted output

## 🚀 Usage

### Run the script in PowerShell (requires Internet connection for GeoIP lookup):

```powershell
.\get_externalconnections.ps1

