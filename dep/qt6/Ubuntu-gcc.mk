# Copyright (c) 2022 Stephen David Cope III. All rights reserved.

defines                += -D_REENTRANT
#cxxflags              +=
#incpath               +=
#lflags                +=
#libs                  +=

depincpath             += -I$(qt.inc_dir)\
                          $(foreach mod,$(qt),-I$(qt.inc_dir)/Qt$(mod))
deplflags              += -Wl,-rpath,$(qt.lib_dir)
deplibs                += $(foreach mod,$(qt),$(qt.lib_dir)/libQt6$(mod).so)

# Some additional utilities are required for building Qt apps.
qt.moc                 := $(qt.root)/libexec/moc
qt.rcc                 := $(qt.root)/libexec/rcc
