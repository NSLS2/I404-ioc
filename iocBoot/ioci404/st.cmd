#!../../bin/linux-x86_64/i404

## You may have to change i404 to something else
## everywhere it appears in this file

< envPaths

cd ${TOP}

## Register all support components
dbLoadDatabase("dbd/i404.dbd")
i404_registerRecordDeviceDriver(pdbbase)

epicsEnvSet("STREAM_PROTOCOL_PATH", "i404App/Db")
# Initialise connection
drvAsynIPPortConfigure("COM1", "xf28ida-tsrv2:4016")
asynOctetSetInputEos("COM1",0,"\r\n")
asynOctetSetOutputEos("COM1",0,"\r\n")
#asynSetTraceMask("COM1",0,"0x9")
#asynSetTraceIOMask("COM1",0,"0x2")

# Load record instances
dbLoadRecords("db/I404.template","Sys=XF:28IDA-BI:1, Dev={BPM:2},PORT=COM1,CAP0=100pF,CAP1=3300pF")
dbLoadRecords("db/dsp.db", "Sys=XF:28IDA-BI:1,Dev={BPM:2}")
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

create_monitor_set("I404.req",15,"DEVICE=Sys=XF:28IDA-BI:1, Dev={BPM:2}")
