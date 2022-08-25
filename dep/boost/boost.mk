# Copyright (c) 2022 Stephen David Cope III. All rights reserved.

ifneq ($(filter $(deps),boost),)
$(error Cannot include Boost more than once)
endif

ifeq ($(boost.version),)
$(error Cannot include Boost without specifying a version)
endif

ifeq ($(boost),)
$(error Cannot include Boost without specifying any modules)
endif

deps                   += boost
boost.root             := $(dep_root_external)/Boost/$(boost.version)
boost.inc_dir          := $(boost.root)/include
boost.lib_dir          := $(boost.root)/lib

defines                += $(cxx_D)$(D_prefix)BOOST_ENABLED=1\
                          $(cxx_D)$(D_prefix)BOOST_VERSION=$(boost.version)

include $(mkable_dep_dir)/boost/$(os)-$(toolchain).mk
