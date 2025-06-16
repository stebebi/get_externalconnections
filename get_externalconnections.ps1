# Define output log file
$LogFile = "$env:TEMP\ExternalConnectionsLog.txt"

# Get active TCP connections (excluding local IPs)
$Connections = Get-NetTCPConnection | Where-Object {
    $_.RemoteAddress -notmatch "^(127\.0\.0\.1|::1|192\.168\.|10\.|172\.16\.)"
}

# Function to retrieve GeoIP info
Function Get-GeoIP {
    param([string]$IPAddress)
    try {
        $GeoData = Invoke-RestMethod -Uri "http://ip-api.com/json/$IPAddress"
        return "$($GeoData.country), $($GeoData.city) [$IPAddress]"
    } catch {
        return "GeoIP Lookup Failed [$IPAddress]"
    }
}

# Process results & append GeoIP info
$Results = $Connections | ForEach-Object {
    $GeoInfo = Get-GeoIP -IPAddress $_.RemoteAddress
    "$($_.LocalAddress):$($_.LocalPort) -> $GeoInfo (Port: $($_.RemotePort)) - State: $($_.State)"
}

# Save results to file
$Results | Out-File -FilePath $LogFile

# Display results
Write-Host "External Connections Logged at: $LogFile"
$Results | Format-Table -AutoSize
