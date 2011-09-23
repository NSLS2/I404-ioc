#!../../bin/linux-x86/i404

## You may have to change i404 to something else
## everywhere it appears in this file

< envPaths

cd ${TOP}

## Register all support components
dbLoadDatabase("dbd/i404.dbd")
i404_registerRecordDeviceDriver(pdbbase)

epicsEnvSet("STREAM_PROTOCOL_PATH", "i404App/Db")
# Initialise test
drvAsynIPPortConfigure("COM1", "moxa:4002")
#drvAsynSerialPortConfigure("COM1", "/dev/ttyS0")
asynOctetSetInputEos("COM1",0,"\r\n")
asynOctetSetOutputEos("COM1",0,"\r\n")
#asynSetOption("COM1", 0, "baud", "115200")
#asynSetOption("COM1", 0, "bits", "8")
#asynSetOption ("COM1", 0, "parity", "none")
#asynSetOption ("COM1", 0, "stop", "1")
#asynSetOption ("COM1", 0, "clocal", "Y")
#asynSetOption ("COM1", 0, "crtscts", "N")
#asynSetTraceMask("COM1",0,"0x9")
#asynSetTraceIOMask("COM1",0,"0x2")

# Load record instances
dbLoadTemplate("db/I404.substitutions")
dbLoadRecords("db/asyn.db","DEVICE=ixsrd{i404:1},PORT=COM1,ADDR=0")

# autosave/restore mechanisms
save_restoreSet_Debug(0)
save_restoreSet_IncompleteSetsOk(1)
save_restoreSet_DatedBackupFiles(1)

set_savefile_path("${TOP}/as","/save")
set_requestfile_path("${TOP}/as","/req")

set_pass1_restoreFile("modules_I404.sav")

#cd ${TOP}/iocBoot/${IOC}
iocInit()

create_monitor_set("modules_I404.req", 15 , "")
