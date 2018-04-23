# IOC instance Makefile
# Generates envPaths and expands the instance
# specific substitution files.

TOP = ../..
include $(TOP)/configure/CONFIG
ARCH = rhel7-x86_64
TARGETS = envPaths

# Make sure these archive files are fully expanded
USR_ARCHIVEFLAGS += -V

#----------------------------------------------------
# Create and install db files
#


#----------------------------------------------------
# Create and install IOC archive file
#
ARCHIVE += ioc-tst-sds.archive

#----------------------------------------------------
# Create and install IOC autosave file
#
REQ += ioc-tst-sds.req

include $(CONFIG)/RULES
include $(CONFIG)/RULES.ioc-targets
