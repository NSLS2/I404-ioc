#!../../bin/linux-x86_64/i404

## You may have to change i404 to something else
## everywhere it appears in this file

< envPaths

cd ${TOP}

## Register all support components
dbLoadDatabase("dbd/i404.dbd")
i404_registerRecordDeviceDriver(pdbbase)

epicsEnvSet("ENGINEER", "Wayne Lewis x5936")
epicsEnvSet("LOCATION", "XF28IDA{RG:A2}")
epicsEnvSet("STREAM_PROTOCOL_PATH", "i404App/Db")
epicsEnvSet("EPICS_CA_AUTO_ADDR_LIST", "NO")
epicsEnvSet("EPICS_CA_ADDR_LIST", "10.28.0.255")

# Initialise connection
drvAsynIPPortConfigure("COM1", "xf28ida-tsrv2:4016")
asynOctetSetInputEos("COM1",0,"\r\n")
asynOctetSetOutputEos("COM1",0,"\r\n")
#asynSetTraceMask("COM1",0,"0x9")
#asynSetTraceIOMask("COM1",0,"0x2")

# Load record instances
dbLoadRecords("db/I404.db")
#dbLoadRecords("db/dsp.db", "Sys=XF:28IDA-BI:1,Dev={BPM:2}")
dbLoadRecords("db/asyn.db","Sys=XF:28IDA-BI:1,Dev={BPM:2},PORT=COM1,ADDR=0")

# autosave/restore mechanisms
save_restoreSet_Debug(0)
save_restoreSet_IncompleteSetsOk(1)
save_restoreSet_DatedBackupFiles(1)

set_savefile_path("${TOP}/as","/save")
set_requestfile_path("${TOP}/as","/req")

set_pass1_restoreFile("I404.sav")

#cd ${TOP}/iocBoot/${IOC}
iocInit()

create_monitor_set("I404.req",15,"Sys=XF:28IDA-BI:1, Dev={BPM:2}")

# Create ChannelFinder file
cd ${TOP}
dbl > ./records.dbl
system "cp ./records.dbl /cf-update/$HOSTNAME.$IOCNAME.dbl"

