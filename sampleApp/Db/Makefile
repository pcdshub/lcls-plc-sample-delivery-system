TOP=../..
include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE

#----------------------------------------------------
#  Optimization of db files using dbst (DEFAULT: NO)
#DB_OPT = YES

#----------------------------------------------------
# Create and install (or just install)
# databases, templates, substitutions like this
DB += iocAdmin.db
DB += sample_selection.db
DB += asynRecord.db
DB += TwincatAppInfo.db
DB += TwincatPlcTask.db
DB += TwincatTaskInfo.db

DB += sample_flow_integration.db
DB += sample_flow_accumulators.db

#M2 Stuff
DB += sds-m2-sampleSelection.db
DB += sds-m2-nozzleselector.db
DB += sds-m2-modbus.db
DB += sds-m2-regulatorLimiter.db
#DB += sds-m2-setpointForwarder.db

#M3 Stuff
DB += m3-sds-modbus.db
DB += ALI_manip_aux_records.db
DB += ALI_propValve_aux_records.db
#----------------------------------------------------
# Create and install (or just install)
# Archive files, templates, substitutions like this
#


ARCHIVE += ioc-archive.tpl-arch
ARCHIVE += flowmeter.tpl-arch
ARCHIVE += sds-m2.tpl-arch
ARCHIVE += sampleFlowAccumulators.tpl-arch


#----------------------------------------------------
# Create and install (or just install)
# Autosave request files, templates, substitutions like this
#

REQ += ioc-req.sub-req
REQ += sampleFlowAccumulators.req
REQ += autosave-sample_selection.tpl-req
REQ += sds-m2.tpl-req


# Nothing to build for autosave, just install from $AUTOSAVE/db
DB_INSTALLS += $(AUTOSAVE)/db/save_restoreStatus.db

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

