IOC_TOP = /reg/g/pcds/epics/ioc/common/ads-ioc/R0.8.0
IOC_INSTANCE_PATH := $(shell pwd)

# Set PRODUCTION_IOC to 1 to move from a testing to a production IOC:
PRODUCTION_IOC := 1

PROJECT_NAME := SDS
PROJECT_PATH := ../../sdsPLC/SDS.tsproj
PLC := SDSPLC

PYTMC_OPTS := 
PREFIX := PLC:$(PLC)

# With two $$, as in $$(IOC) below, this will be expanded in the
# environment of st.cmd:
DB_PARAMETERS := 'PREFIX=$(PREFIX):,IOCNAME=$$(IOC),IOC=$$(IOC),P=ICL:SDS'

# If you know the netconfig name of the PLC, enter it here.  If specified, this
# will be used in place of the auto-detected IP address from the PLC project:
PLC_HOSTNAME := plc-sds-raptor
# You may also specify the AMS Net ID of the PLC, but it's usually OK to
# leave this blank as it can be found in the project:
PLC_AMS_NET_ID := 172.21.148.118.1.1

include $(IOC_TOP)/iocBoot/templates/Makefile.base
