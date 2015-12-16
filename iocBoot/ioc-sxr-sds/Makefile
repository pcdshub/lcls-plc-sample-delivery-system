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
# Files for things in epics
#

#----------------------------------------------------
# Create and install IOC archive file
#
#ARCHIVE += ioc-sxr-sds.archive

#----------------------------------------------------
# Create and install IOC autosave file
#
#REQ += ioc-sxr-sds.req

include $(CONFIG)/RULES
include $(CONFIG)/RULES.ioc-targets
