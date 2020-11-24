#!../../bin/linux-x86_64/i404

## You may have to change i404 to something else
## everywhere it appears in this file

< envPaths
< /epics/common/xf18idb-ioc1-netsetup.cmd

cd ${TOP}

## Register all support components
dbLoadDatabase("dbd/i404.dbd")
i404_registerRecordDeviceDriver(pdbbase)

epicsEnvSet("ENGINEER",  "kgofron x5283")
epicsEnvSet("LOCATION", "XF18IDB{RG:B3}")
epicsEnvSet("STREAM_PROTOCOL_PATH", "i404App/Db")
epicsEnvSet("SYS", "XF:18IDB-CT")
epicsEnvSet("IOC_PREFIX", "$(SYS){IOC:i404}")

# Initialise connection
# Using 10.18.2.55 small MOXA, because the RS-232 cable to 10.18.2.54 MOXA does not work.
# The RS232 cable requires that mini-DIN 6 pin 3 and 5 are connected.
# This seems to switch connection from fiber to RS232 on the i404 Rev.2 hardware
drvAsynIPPortConfigure("COM1", "xf18idb-tsrv2.nsls2.bnl.local:4001")
asynOctetSetInputEos("COM1",0,"\r\n")
asynOctetSetOutputEos("COM1",0,"\r\n")
#asynSetTraceMask("COM1",0,"0x9")
#asynSetTraceIOMask("COM1",0,"0x2")

# Load record instances
dbLoadRecords("db/I404.db")
#dbLoadRecords("db/dsp.db", "Sys=XF:28IDA-BI:1,Dev={BPM:2}")
dbLoadRecords("db/asyn.db","Sys=XF:18IDB-BI,Dev={i404:1},PORT=COM1,ADDR=0")
dbLoadRecords("$(EPICS_BASE)/db/iocAdminSoft.db","IOC=$(IOC_PREFIX)")

# autosave/restore mechanisms
save_restoreSet_Debug(0)
save_restoreSet_IncompleteSetsOk(1)
save_restoreSet_DatedBackupFiles(1)

set_savefile_path("${TOP}/as","/save")
set_requestfile_path("${TOP}/as","/req")
set_requestfile_path("${EPICS_BASE}/as","/req")

set_pass1_restoreFile("I404.sav")
set_pass1_restoreFile("asynRecord_settings.sav")

#cd ${TOP}/iocBoot/${IOC}
iocInit()

create_monitor_set("I404.req",15,"Sys=XF:18IDB-BI, Dev={i404:1}")
create_monitor_set("asynRecord_settings.req", "15", "P=XF:18IDB-BI,R={i404:1}Asyn")

dbpf("XF:18IDB-BI{i404:1}Asyn.TB3","1")
dbpf("XF:18IDB-BI{i404:1}Asyn.TIB1","1")
# Create ChannelFinder file
cd ${TOP}
dbl > ./records.dbl
#system "cp ./records.dbl /cf-update/$HOSTNAME.$IOCNAME.dbl"

