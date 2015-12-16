#!/bin/bash

export IOC="ioc-cxi-sds"

# Setup the IOC user environment
source /reg/d/iocCommon/All/cxi_env.sh

# Make sure the IOC's data directories are ready for use

$RUNUSER "mkdir -p $IOC_DATA/$IOC/autosave"
$RUNUSER "mkdir -p $IOC_DATA/$IOC/archive"
$RUNUSER "mkdir -p $IOC_DATA/$IOC/iocInfo"

# Make sure permissions are correct
$RUNUSER "chmod ug+w -R $IOC_DATA/$IOC"

# Copy the archive file to iocData
$RUNUSER "cp ../../archive/$IOC.archive $IOC_DATA/$IOC/archive"

# Launch the IOC
$RUNUSER "$PROCSERV --logfile $IOC_DATA/$IOC/iocInfo/ioc.log_$CREATE_TIME --name $IOC 30012 ../../bin/linux-x86/sampleDelivery st.cmd"
