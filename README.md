# HP Printer Toner Monitor

Automated monitoring system for HP printers that checks toner levels via web interface and sends email alerts when cartridges are low.

## Features

- **Automated Monitoring**: Checks multiple HP printers simultaneously
- **Color/Mono Detection**: Automatically detects printer type and monitors appropriate cartridges
- **Low Toner Alerts**: Sends email notifications when toner levels reach 20% or below
- **HTML Parsing**: Uses range-based regex for reliable data extraction
- **Scheduled Execution**: Runs twice daily (08:00 and 14:00) via Windows Task Scheduler
- **Support for <10% Levels**: Handles HP's "<10%" toner display format

## Installation

1. **Download Files**
   ```
   C:\PrinterMonitor\
   ├── complete_printer_monitor.ps1
   ├── setup_scheduler.ps1
   └── setup_scheduler.bat
   ```

2. **Configure Settings**
   
   Edit `complete_printer_monitor.ps1`:
   ```powershell
   # Update with your printer IPs
   $printerIPs = @(
       "192.168.1.100",
       "192.168.1.101"
   )
   
   # Configure email settings
   $EMAIL_SMTP_SERVER = "smtp.company.local"
   $EMAIL_FROM = "printer-alerts@company.local"
   $EMAIL_TO = "supplies@company.local"
   ```

3. **Run Setup**
   - Right-click `setup_scheduler.bat`
   - Select "Run as administrator"
   - Follow prompts

## Configuration

### Printer Settings
- Add printer IP addresses to the `$printerIPs` array
- Ensure printers have web interface enabled
- Test access via browser: `http://[printer-ip]`

### Email Settings
- Configure SMTP server details
- For internal networks, authentication is usually not required
- Test email connectivity before deployment

### HTML Parsing Range
Adjust for different HP printer models:
```powershell
$SUPPLY_START_LINE = 180  # Start line for supply section
$SUPPLY_END_LINE = 220    # End line for supply section
$YELLOW_CHECK_LINES = 5   # Lines to check for color detection
```

## Usage

### Manual Execution
```powershell
PowerShell -ExecutionPolicy Bypass -File "C:\PrinterMonitor\complete_printer_monitor.ps1"
```

### Scheduled Execution
- Task runs automatically twice daily
- Check Task Scheduler: `Win + R` → `taskschd.msc`
- Look for "HPPrinterMonitor" task

### Output Example
```
HP PRINTER TONER MONITOR
========================
>>> Checking 192.168.1.100 <<<
192.168.1.100 - COLOR printer detected
192.168.1.100 - Black : 15%
192.168.1.100 - Cyan : 45%
192.168.1.100 - Magenta : <10%
192.168.1.100 - Yellow : 30%

REPLACEMENT NEEDED:
192.168.1.100
```

## Supported Printers

Tested on HP printer models with embedded web servers:
- HP LaserJet series
- HP OfficeJet series
- HP PageWide series

## Email Alerts

When toner levels reach 20% or below, the system sends detailed email alerts:

```
Subject: PRINTER TONER ALERT - 192.168.1.100 - Magenta

Dear Manager,

Printer 192.168.1.100 has reached critical toner level.

Details:
- Printer IP: 192.168.1.100
- Printer Type: Color
- Toner: Magenta
- Current Level: <10%
- Status: Critical Level

Please order replacement cartridge.
```

## Troubleshooting

### Common Issues

1. **Printer Not Responding**
   - Verify IP address and network connectivity
   - Check if web interface is enabled on printer
   - Test browser access: `http://[printer-ip]`

2. **Email Not Sending**
   - Verify SMTP server settings
   - Check network connectivity to mail server
   - Test SMTP port: `Test-NetConnection smtp.server.com -Port 25`

3. **Toner Levels Not Detected**
   - Adjust HTML parsing range (`$SUPPLY_START_LINE`, `$SUPPLY_END_LINE`)
   - Check printer web interface HTML structure
   - Enable debug output for troubleshooting

### Debug Mode
Enable detailed logging by running script manually and reviewing output.

## Requirements

- Windows PowerShell 5.1 or later
- Network access to HP printers
- SMTP server access for email alerts
- Administrator privileges for task scheduling

## License

This project is provided as-is for educational and internal use purposes.

## Contributing

Feel free to submit issues and enhancement requests.