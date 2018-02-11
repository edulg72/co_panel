# Waze Panel Colombia #

Production server: [panel.wazecolombia.co](http://panel.wazecolombia.co)

## About ##

The system shows all URs, MPs and PUs open in country so editors can easily see where they are.

## Data loading ##

In order to show URs, MPs and PUs the system needs first to get data from Waze servers. This is done
through Ruby scripts that feeds the database.

### scan_UR.rb ###
Scans URs and MPs from the map.

```
$ ruby scan_UR.rb <user> <password> <west longitude> <north latitude> <east longitude> <south latitude> <step>
```

### scan_PU.rb ###
Scans PUs from the map.

```
$ ruby scan_PU.rb <user> <password> <west longitude> <north latitude> <east longitude> <south latitude> <step>
```
