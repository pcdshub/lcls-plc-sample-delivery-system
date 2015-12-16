# IOC instance Makefile
# Generates envPaths and expands the instance
# specific substitution files.

TOP = ../..
include $(TOP)/configure/CONFIG
ARCH = linux-x86
TARGETS = envPaths

# Make sure these archive files are fully expanded
USR_ARCHIVEFLAGS += -V

#----------------------------------------------------
# Create and install IOC motors db file
#

#----------------------------------------------------
# Create and install IOC archive file
#
#ARCHIVE += ioc-amo-sds.archive

#----------------------------------------------------
# Create and install IOC autosave file
#
#REQ += ioc-amo-sds.req

include $(CONFIG)/RULES
include $(CONFIG)/RULES.ioc-targets
