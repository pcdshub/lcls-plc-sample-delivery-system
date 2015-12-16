
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

drvAsynIPPortConfigure("$(PLC)","$(PLC):502",0,0,1)
#modbusInterposeConfig(const char *pootName, 
#                      int slaveAddress, 
#                      modbusLinkType linkType,
#                      int timeoutMsec)
modbusInterposeConfig("$(PLC)",0,0,0)



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
drvModbusAsynConfigure("AI_PORT",      "$(PLC)", 0, 4,  0x8000, 100,    0,  100, "BK")

# INT Outputs (EPICS -> PLC) starting at 0x8000 on function code 6
# I set the modbus length to 50, pretty much an arbitrary length, it can be longer (up to 123)
drvModbusAsynConfigure("AO_PORT",      "$(PLC)", 0, 6,  0x8000, 100,    0,  100, "BK")

# FLOAT Inputs (PLC -> EPICS) starting at 0x3000 on function code 3, data type 7
# I set the modbus length to 100, pretty much an arbitrary length, it can be longer
drvModbusAsynConfigure("aiFLOAT_PORT",      "$(PLC)", 0, 3,  0x3000, 100,    7,  100, "BK")

# DINT aka LONG Inputs (PLC -> EPICS) starting at 0x31F4 on function code 3, data type 5
# I set the modbus length to 100, pretty much an arbitrary length, it can be longer
# Note: the offset is 500 in hex. HEX...
drvModbusAsynConfigure("aiLONG_PORT",      "$(PLC)", 0, 3,  0x31F4, 120,    5,  100, "BK")

# DINT aka LONG Outputs (EPICS -> PLC) starting at 0x31F4 on function code 3, data type 5
# I set the modbus length to 100, pretty much an arbitrary length, it can be longer
# Note: the offset is 500 in hex. HEX...
drvModbusAsynConfigure("aoLONG_PORT",      "$(PLC)", 0, 3,  0x31F4, 120,    5,  100, "BK")

# COIL Inputs (PLC -> EPICS) starting at 0x8000 on function code 2.
# I set the modbus length to 256, the maximum array size in the Beckhoff PLC
drvModbusAsynConfigure("BI_PORT",      "$(PLC)", 0, 2,  0x8000, 256,    0,  100, "BK")

# COIL Outputs (EPICS -> PLC) starting at 0x8000 on function code 5.
drvModbusAsynConfigure("BO_PORT",  "$(PLC)", 0, 5,  0x8000, 256,   0,  100,  "BK")

# Extra PLC memory input (PLC -> EPICS) starting at 0x3000 on function code 3.
# I set the modbus length to 3, that's how many 16-bit registers we are currently using, it can be longer
#drvModbusAsynConfigure("MB_PLC_MEM_PORT_INPUT", 0,  "$(PLC)", 3,  0x3000, 100,   0,  100,  "BK")


