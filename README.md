# Efficiency-calc
The aim of this tool is to help handle data from very specific electrical measuring (AC/DC inverter testing) in semiautomated way to calculate efficiency in different power levels and overall according to standardized metrics.

## Inputs
Data logged by measuring devices into csv and txt files. TBD (specification of files and where it comes from). Measuring is expected to be done for predefinet power levels for given period of time. The ongoing automated data processing is expecting majority of data in these levels. Not leveled measured data shoud be cut before processing.

## Original cmd-line version
Original calculation is done in `main.m` file and is kept for future possible batch implementation. Includes generated import of csv and txt datalog files in `import1.m`, `import2.m` connected to `import.m`. Timeseries of mesured data from import files are not synchronized. To achieve timeliness both input timeseries are interpolated onto a new timeline of intersecting time interval. Timescale is set to seconds and can be used even higher granularity if necessary.

## Desktop version
Original scripts are ported to desktop. File imports are still using `import1.m` and `import2.m`. Timescale merging (interpoation) is done in desktop app. Time-scale knob is prepared for usage to achive higher time density if necessary for fine time scaling.

Imports and data processing can last longer according to data volume and selected timescale. To monitor duration of calculations special "altimeter" was implemented together with system timer to demonstrate. Also green lamp next to altimeter turns red when calculating.

## TBD - to be done
Timescale can be variable - the knob needs testing
Levels can be set in advance (more levels)
Output charts with leveled efficiency curve in .fig format.
Detected values added to levels will be marked by different colors.
