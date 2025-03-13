#!../../bin/linux-x86_64/i404

< /epics/common/xf09id1-ioc1-netsetup.cmd
< envPaths

cd ${TOP}

## Register all support components
dbLoadDatabase("dbd/i404.dbd")
i404_registerRecordDeviceDriver(pdbbase)

epicsEnvSet("ENGINEER",  "C. Engineer")
epicsEnvSet("LOCATION", "XF09IDB")
epicsEnvSet("STREAM_PROTOCOL_PATH", "i404App/Db")

epicsEnvSet("SYS", "XF:09IDB-BI")
epicsEnvSet("DEV", "{i404:1}")
epicsEnvSet("IOC_SYS", "XF:09IDB-CT")
epicsEnvSet("IOC_DEV", "{IOC:i404}")

drvAsynIPPortConfigure("COM1", "10.66.66.87:4001")
#asynOctetSetInputEos("COM1",0,"\r\n")
#asynOctetSetOutputEos("COM1",0,"\r\n")
#asynSetTraceMask("COM1",0,"0x9")
#asynSetTraceIOMask("COM1",0,"0x2")

# Load record instances
dbLoadRecords("db/I404.db")
dbLoadRecords("db/asyn.db","Sys=$(SYS),Dev=$(DEV),PORT=COM1,ADDR=0")
dbLoadRecords("$(EPICS_BASE)/db/iocAdminSoft.db","IOC=$(IOC_SYS)$(IOC_DEV)")

dbLoadRecords("$(DEVIOCSTATS)/db/iocAdminSoft.db", "IOC=$(IOC_SYS)$(IOC_DEV)")
dbLoadRecords("$(AUTOSAVE)/db/save_restoreStatus.db", "P=$(IOC_SYS)$(IOC_DEV)")
dbLoadRecords("${TOP}/db/reccaster.db", "P=${IOC_SYS}$(IOC_DEV)RecSync")

# autosave/restore mechanisms
save_restoreSet_Debug(0)
save_restoreSet_IncompleteSetsOk(1)
save_restoreSet_DatedBackupFiles(1)

set_savefile_path("${TOP}/as","/save")
set_requestfile_path("${TOP}/as","/req")
set_requestfile_path("${EPICS_BASE}/as","/req")

set_pass0_restoreFile("info_settings.sav")
set_pass0_restoreFile("info_positions.sav")
set_pass1_restoreFile("info_settings.sav")

makeAutosaveFileFromDbInfo("$(TOP)/as/req/info_settings.req", "autosaveFields")
makeAutosaveFileFromDbInfo("$(TOP)/as/req/info_positions.req", "autosaveFields_pass0")

iocInit()

create_monitor_set("info_settings.req", 30)
create_monitor_set("info_positions.req", 15)

# Uncomment the following lines to enable printing of communication messages (for debugging)
#dbpf("$(SYS)$(DEV)Asyn.TB3","1")
#dbpf("$(SYS)$(DEV)Asyn.TIB1","1")

# Create ChannelFinder file
cd $(TOP)

dbl > $(TOP)/records.dbl

