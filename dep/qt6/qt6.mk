# Copyright (c) 2022 Stephen David Cope III. All rights reserved.

ifneq ($(filter $(deps),qt),)
$(error Cannot include Qt more than once)
endif

ifeq ($(qt.version),)
$(error Cannot include Qt without specifying a version)
endif

ifeq ($(qt),)
$(error Cannot include Qt without specifying any modules)
endif

# Translate the mkable toolchain to the Qt toolchain:
#   /path/to/Qt/<qt.version>/<qt.toolchain>
qt.toolchain := $(toolchain)
ifeq ($(toolchain),clang)
    qt.toolchain := macos
endif
ifeq ($(toolchain),gcc)
    qt.toolchain := gcc_64
endif
ifeq ($(toolchain),vs2019)
    qt.toolchain := msvc2019_64
endif

deps                   += qt
qt.root                := $(dep_root_external)/Qt/$(qt.version)/$(qt.toolchain)
qt.bin_dir             := $(qt.root)/bin
qt.inc_dir             := $(qt.root)/include
qt.lib_dir             := $(qt.root)/lib

defines                += $(cxx_D)$(D_prefix)QT_ENABLED=1\
                          $(cxx_D)$(D_prefix)QT_VERSION=$(qt.version)\
                          $(cxx_D)QT_DEPRECATED_WARNINGS\
                          $(foreach mod,$(qt),$(cxx_D)QT_$(call fn.to_upper,$(mod))_LIB)

include $(mkable_dep_dir)/qt6/recipe.mk
include $(mkable_dep_dir)/qt6/$(os)-$(toolchain).mk
