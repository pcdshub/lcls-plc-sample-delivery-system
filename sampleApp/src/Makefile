TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#=============================
# Build an ioc application
# Use PROD_IOC_RTEMS for RTEMS only
# Use PROD_IOC_Linux for Linux only
PROD_IOC = sampleDelivery

# sampleDelivery.dbd will be created and installed
DBD += sampleDelivery.dbd

sampleDelivery_DBD += base.dbd
sampleDelivery_DBD += iocAdmin.dbd
sampleDelivery_DBD += autosaveSupport.dbd
sampleDelivery_DBD += asyn.dbd
sampleDelivery_DBD += stream.dbd
sampleDelivery_DBD += modbus.dbd
sampleDelivery_DBD += modbusSupport.dbd
sampleDelivery_DBD += caPutLog.dbd

sampleDelivery_DBD += genSubRecord.dbd

# Sample Integrator
sampleDelivery_DBD += SampleIntegrator.dbd

# <name>_registerRecordDeviceDriver.cpp will be created from <name>.dbd
sampleDelivery_SRCS += sampleDelivery_registerRecordDeviceDriver.cpp
sampleDelivery_SRCS_DEFAULT += sampleDeliveryMain.cpp
sampleDelivery_SRCS += SampleIntegrator.c

# Add locally compiled object code
#sampleDelivery_SRCS += dbSubExample.c

sampleDelivery_LIBS += stream
#sampleDelivery_LIBS += calc

sampleDelivery_LIBS += autosave
sampleDelivery_LIBS += devIocStats
sampleDelivery_LIBS += modbus
sampleDelivery_LIBS += caPutLog
sampleDelivery_LIBS += genSub
sampleDelivery_LIBS += asyn
sampleDelivery_LIBS += $(EPICS_BASE_IOC_LIBS)

#Disable Regexp for RTEMS-beatnik as pcre lib not avail
ifneq '$(T_A)' 'RTEMS-beatnik'
PCRE_INCLUDE=/usr/include
ifeq '$(EPICS_HOST_ARCH)' 'linux-x86_64'
PCRE_LIB=/usr/lib64
else
PCRE_LIB=/usr/lib
endif
endif

ifdef PCRE
LIB_LIBS += pcre
else
ifneq ($(words $(PCRE_LIB) $(PCRE_INCLUDE)),0)
PROD_SYS_LIBS_DEFAULT += pcre
PROD_SYS_LIBS_WIN32 += $(PCRE_LIB)\\pcre
SHRLIB_DEPLIB_DIRS += $(PCRE_LIB)
endif
endif

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

