# Copyright (c) 2022 Stephen David Cope III. All rights reserved.

#defines               +=
#cxxflags              +=
#incpath               +=
#lflags                +=
#libs                  +=

depincpath             += /I$(qt.inc_dir)\
                          $(foreach mod,$(qt),/I$(qt.inc_dir)/Qt$(mod))
#deplflags             +=
deplibs                += $(foreach mod,$(qt),$(call fn.chk_seps,$(qt.lib_dir)/Qt6$(mod).lib))

# Some additional utilities are required for building Qt apps.
qt.moc                 := $(qt.bin_dir)/moc
qt.rcc                 := $(qt.bin_dir)/rcc

# Ensure dependent libraries can be found on the system path.
export PATH := $(qt.bin_dir);$(PATH)
