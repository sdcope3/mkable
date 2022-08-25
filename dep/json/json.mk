# Copyright (c) 2022 Stephen David Cope III. All rights reserved.

ifneq ($(filter $(deps),json),)
$(error Cannot include json more than once)
endif

ifeq ($(json.version),)
$(error Cannot include json without specifying a version)
endif

deps                   += json
json.root              := $(dep_root_internal)/json
#json.bin_dir          :=
json.inc_dir           := $(json.root)/include
#json.lib_dir          :=

defines                += $(cxx_D)$(D_prefix)JSON_ENABLED=1\
                          $(cxx_D)$(D_prefix)JSON_VERSION=$(json.version)

depincpath             += $(cxx_I)$(json.inc_dir)
