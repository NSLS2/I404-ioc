TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#=============================
# Build the IOC application

PROD_IOC = i404
# i404.dbd will be created and installed
DBD += i404.dbd

# i404.dbd will be made up from these files:
i404_DBD += base.dbd

# Include dbd files from all support applications:
i404_DBD += asyn.dbd
i404_DBD += calcSupport.dbd
i404_DBD += stream.dbd
i404_DBD += drvAsynIPPort.dbd
i404_DBD += drvAsynSerialPort.dbd
i404_DBD += asSupport.dbd
i404_DBD += system.dbd
i404_DBD += devIocStats.dbd

ifneq ($(RECCASTER),)
i404_DBD += reccaster.dbd
i404_LIBS += reccaster
endif

# Add all the support libraries needed by this IOC
i404_LIBS += calc sscan stream asyn autosave devIocStats

# i404_registerRecordDeviceDriver.cpp derives from i404.dbd
i404_SRCS += i404_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
i404_SRCS_DEFAULT += i404Main.cpp
i404_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#i404_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Finally link to the EPICS Base libraries
i404_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

