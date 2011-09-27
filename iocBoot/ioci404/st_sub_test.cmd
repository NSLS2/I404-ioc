#!../../bin/linux-x86/stream

## You may have to change stream to something else
## everywhere it appears in this file

< envPaths

cd ${TOP}

## Register all supPORT components
dbLoadDatabase "dbd/stream.dbd"
stream_registerRecordDeviceDriver pdbbase

## Load record instances
###dbLoadRecords "iocBoot/iocstream/subtest.db"

# Initialise test
epicsEnvSet "STREAM_PROTOCOL_PATH", "."
drvAsynSerialPortConfigure "COM1", "/dev/ttyS0"
asynOctetSetInputEos "COM1",0,"\r\n"
asynOctetSetOutputEos "COM1",0,"\r\n"
asynSetOption ("COM1", 0, "baud", "115200")
asynSetOption ("COM1", 0, "bits", "8")
asynSetOption ("COM1", 0, "parity", "none")
asynSetOption ("COM1", 0, "stop", "1")
asynSetOption ("COM1", 0, "clocal", "Y")
asynSetOption ("COM1", 0, "crtscts", "N")
cd ${TOP}/iocBoot/${IOC}
dbLoadTemplate "subtest.substitutions"

cd ${TOP}/iocBoot/${IOC}
iocInit

## Start any sequence programs
#seq sncxxx,"user=steveHost"
