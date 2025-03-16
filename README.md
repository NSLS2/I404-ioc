IOC for I404 electrometer
=========================

NOTE: The terminal mode in I404 must be disabled, otherwise the IOC will not work. Check if the terminal mode is disabled by sending ``SYST:COMM:TERM?`` command (must return 0). Disable terminal mode by sending ``SYST:COMM:TERM 0``.

Have a look at the vendor-provided material in $(TOP)/doc.

If you are NOT using the EPICS debian packages 
(see http://epics.nsls2.bnl.gov/debian/ for details), you will naturally
need to add the appropriate lib+dbd locations in configure/RELEASE. The 
i404 application depends on asyn,stream device, and scalcout (calcSupport).
