#!../../bin/linux-x86/sampleDelivery

< envPaths
epicsEnvSet( "ENGINEER", "Alex Wallace (awallace)" )
epicsEnvSet( "LOCATION", "SXR:SDS:IOC:01" )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(TOP/sampleApp/protocol" )
epicsEnvSet( "IOCSH_PS1", "$(IOC)> " )
cd( "../.." )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/sampleDelivery.dbd")
sampleDelivery_registerRecordDeviceDriver(pdbbase)

#Set some env variables
##Basic ioc stuff
epicsEnvSet( "LOC", "SXR")
epicsEnvSet( "SYS", "SDS") #Sample Delivery System
epicsEnvSet( "PLC", "plc-sds-sabertooth")
epicsEnvSet("EPICS_PV", "IOC:$(LOC):SDS:01")


######################################################################################
# Beckhoff ModBus TCP Client Setup
# Here we set up the various ports for the Beckhoff PLC modbus interface
######################################################################################

# Use the following commands for TCP/IP
#drvAsynIPPortConfigure(const char *portName, 
#                       const char *hostInfo,
#                       unsigned int priority, 
#                       int noAutoConnect,
#                       int noProcessEos);

drvAsynIPPortConfigure("plc-sds-sabertooth","172.21.39.69:502",0,0,1)
#modbusInterposeConfig(const char *portName, 
#                      int slaveAddress, 
#                      modbusLinkType linkType,
#                      int timeoutMsec)
modbusInterposeConfig("plc-sds-sabertooth",0,0,0)



# Make sure that these port configurations include the correct modbusLength,
# otherwise you might see your records initialize as unconnected...

#drvModbusAsynConfigure(portName, 
#                       tcpPortName,
#                       slaveAddress, 
#                       modbusFunction, 
#                       modbusStartAddress, 
#                       modbusLength,
#                       dataType,  #0-UINT16, 7-FLOAT32LE, 8-FLOAT32BE
#                       pollMsec, 
#                       plcType);

# INT Inputs (PLC -> EPICS) starting at 0x8000 on function code 4
drvModbusAsynConfigure("AI_PORT",      "plc-sds-sabertooth", 0, 4,  0x8000, 50,    0,  100, "BK")

# INT Outputs (EPICS -> PLC) starting at 0x8000 on function code 6
# I set the modbus length to 50, pretty much an arbitrary length, it can be longer (up to 123)
drvModbusAsynConfigure("AO_PORT",      "plc-sds-sabertooth", 0, 6,  0x8000, 50,    0,  100, "BK")

# FLOAT Inputs (PLC -> EPICS) starting at 0x3000 on function code 3, data type 7
# I set the modbus length to 100, pretty much an arbitrary length, it can be longer
drvModbusAsynConfigure("aiFLOAT_PORT",      "plc-sds-sabertooth", 0, 3,  0x3000, 100,    7,  100, "BK")

# DINT aka LONG Inputs (PLC -> EPICS) starting at 0x31F4 on function code 3, data type 5
# I set the modbus length to 100, pretty much an arbitrary length, it can be longer
# Note: the offset is 500 in hex. HEX...
drvModbusAsynConfigure("aiLONG_PORT",      "plc-sds-sabertooth", 0, 3,  0x31F4, 120,    5,  100, "BK")

# DINT aka LONG Outputs (EPICS -> PLC) starting at 0x31F4 on function code 3, data type 5
# I set the modbus length to 100, pretty much an arbitrary length, it can be longer
# Note: the offset is 500 in hex. HEX...
drvModbusAsynConfigure("aoLONG_PORT",      "plc-sds-sabertooth", 0, 3,  0x31F4, 120,    5,  100, "BK")

# COIL Inputs (PLC -> EPICS) starting at 0x8000 on function code 2.
# I set the modbus length to 256, the maximum array size in the Beckhoff PLC
drvModbusAsynConfigure("BI_PORT",      "plc-sds-sabertooth", 0, 2,  0x8000, 256,    0,  100, "BK")

# COIL Outputs (EPICS -> PLC) starting at 0x8000 on function code 5.
drvModbusAsynConfigure("BO_PORT",  "plc-sds-sabertooth", 0, 5,  0x8000, 256,   0,  100,  "BK")

# Extra PLC memory input (PLC -> EPICS) starting at 0x3000 on function code 3.
# I set the modbus length to 3, that's how many 16-bit registers we are currently using, it can be longer
#drvModbusAsynConfigure("MB_PLC_MEM_PORT_INPUT", 0,  "plc-sds-sabertooth", 3,  0x3000, 100,   0,  100,  "BK")

# Extra PLC memory output (EPICS -> PLC) starting at 0x3064 on function code 6 (0x0064 is 100 in hex).
# I set the modbus length to 100, that's how many 16-bit registers we are currently using, it can be longer
# This is for the vacuum setpoint control output.
#drvModbusAsynConfigure("aoVacSP",  "plc-sds-sabertooth", 0, 6,  0x3064, 100,   7,  100,  "BK")



epicsEnvSet("EPICS_CA_MAX_ARRAY_BYTES","2000000",1)




####### Load record instances
dbLoadRecords( "db/iocAdmin.db",        "IOC=$(EPICS_PV)" )
dbLoadRecords( "db/save_restoreStatus.db",  "IOC=$(EPICS_PV)" )


#PLC modbus file
dbLoadRecords("db/sds-m2a-modbus.db",	"DEV=$(LOC):$(SYS):")
dbLoadRecords("db/m2_sample_selection.db",	"P=$(LOC):$(SYS)")
#dbLoadRecords("db/sds-m2-nozzleselector.db",	"P=$(LOC):$(SYS):SEL2")


dbLoadRecords("db/sample_flow_accumulators.db", "DEV=$(LOC):$(SYS),LOC=$(LOC),SYS=$(SYS)")
dbLoadRecords("db/sample_flow_integration.db", "LOC=$(LOC),SYS=$(SYS), FLOWMETER=$(LOC):$(SYS):SEL:Flow")

	

# Setup autosave
save_restoreSet_status_prefix("$(EPICS_PV)" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )

set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "$(TOP)/autosave" )

set_pass0_restoreFile( "$(IOC).sav" )
#set_pass1_restoreFile( "$(IOC).sav" )

# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set( "$(IOC).req", 30, "LOC=$(LOC), SYS=$(SYS)" )



# Initialize the IOC and start processing records
iocInit()


# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

