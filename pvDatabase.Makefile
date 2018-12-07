#
#  Copyright (c) 2018 - Present  European Spallation Source ERIC
#
#  The program is free software: you can redistribute
#  it and/or modify it under the terms of the GNU General Public License
#  as published by the Free Software Foundation, either version 2 of the
#  License, or any newer version.
#
#  This program is distributed in the hope that it will be useful, but WITHOUT
#  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
#  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
#  more details.
#
#  You should have received a copy of the GNU General Public License along with
#  this program. If not, see https://www.gnu.org/licenses/gpl-2.0.txt
#
#
# Author  : Jeong Han Lee
# email   : jeonghan.lee@gmail.com
# Date    : Friday, September 14 10:04:29 CEST 2018
# version : 0.0.2

where_am_I := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

include $(E3_REQUIRE_TOOLS)/driver.makefile
include $(E3_REQUIRE_CONFIG)/DECOUPLE_FLAGS

#include $(where_am_I)/configure/CONFIG_PVDATABASE_VERSION

ifneq ($(strip $(PVDATA_DEP_VERSION)),)
pvData_VERSION=$(PVDATA_DEP_VERSION)
endif

ifneq ($(strip $(PVACCESS_DEP_VERSION)),)
pvAccess_VERSION=$(PVACCESS_DEP_VERSION)
endif


## Exclude linux-ppc64e6500
##EXCLUDE_ARCHS = linux-ppc64e6500





PVDATABASE_SRC:=src

PV:=$(PVDATABASE_SRC)/pv
DATABASE:=$(PVDATABASE_SRC)/database
PVACCESS:=$(PVDATABASE_SRC)/pvAccess
SPECIAL:=$(PVDATABASE_SRC)/special

USR_INCLUDES += -I$(COMMON_DIR)
USR_INCLUDES += -I$(where_am_I)$(PVDATABASE_SRC)
# USR_INCLUDES += -I$(where_am_I)$(DATABASE)

HEADERS += $(PV)/channelProviderLocal.h
HEADERS += $(PV)/pvDatabase.h
HEADERS += $(PV)/removeRecord.h
HEADERS += $(PV)/traceRecord.h

# PVACCESS
SOURCES += $(DATABASE)/pvRecord.cpp
SOURCES += $(DATABASE)/pvDatabase.cpp

# PVACCESS
DBDS    += $(PVACCESS)/registerChannelProviderLocal.dbd
SOURCES += $(PVACCESS)/channelProviderLocal.cpp
SOURCES += $(PVACCESS)/channelLocal.cpp
SOURCES += $(PVACCESS)/monitorFactory.cpp
SOURCES += $(PVACCESS)/registerChannelProviderLocal.cpp


# SPECIAL
SOURCES += $(SPECIAL)/traceRecord.cpp
SOURCES += $(SPECIAL)/removeRecord.cpp

## This RULE should be used in case of inflating DB files 
## db rule is the default in RULES_DB, so add the empty one
## Please look at e3-mrfioc2 for example.

db: 

.PHONY: db 

# USR_DBFLAGS += -I . -I ..
# USR_DBFLAGS += -I $(EPICS_BASE)/db
# USR_DBFLAGS += -I $(APPDB)
#
# SUBS=$(wildcard $(APPDB)/*.substitutions)
# TMPS=$(wildcard $(APPDB)/*.template)
#
# db: $(SUBS) $(TMPS)

# $(SUBS):
#	@printf "Inflating database ... %44s >>> %40s \n" "$@" "$(basename $(@)).db"
#	@rm -f  $(basename $(@)).db.d  $(basename $(@)).db
#	@$(MSI) -D $(USR_DBFLAGS) -o $(basename $(@)).db -S $@  > $(basename $(@)).db.d
#	@$(MSI)    $(USR_DBFLAGS) -o $(basename $(@)).db -S $@

# $(TMPS):
#	@printf "Inflating database ... %44s >>> %40s \n" "$@" "$(basename $(@)).db"
#	@rm -f  $(basename $(@)).db.d  $(basename $(@)).db
#	@$(MSI) -D $(USR_DBFLAGS) -o $(basename $(@)).db $@  > $(basename $(@)).db.d
#	@$(MSI)    $(USR_DBFLAGS) -o $(basename $(@)).db $@

#
# .PHONY: db $(SUBS) $(TMPS)

vlibs:

.PHONY: vlibs

# vlibs: $(VENDOR_LIBS)

# $(VENDOR_LIBS):
# 	$(QUIET) $(SUDO) install -m 555 -d $(E3_MODULES_VENDOR_LIBS_LOCATION)/
# 	$(QUIET) $(SUDO) install -m 555 $@ $(E3_MODULES_VENDOR_LIBS_LOCATION)/

# .PHONY: $(VENDOR_LIBS) vlibs



