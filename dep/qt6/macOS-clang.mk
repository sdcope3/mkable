# Copyright (c) 2022 Stephen David Cope III. All rights reserved.

#defines               +=
#cxxflags              +=
incpath                += -I$(adp.frameworks)/AGL.framework/Headers\
                          -I$(adp.frameworks)/OpenGL.framework/Headers
#lflags                +=
libs                   += -framework AGL\
                          -framework DiskArbitration\
                          -framework IOKit\
                          -framework Metal\
                          -framework OpenGL

depincpath             += -F$(qt.lib_dir)\
                          $(foreach mod,$(qt),-I$(qt.lib_dir)/Qt$(mod).framework/Headers)
deplflags              += -F$(qt.lib_dir) -Wl,-rpath,$(qt.lib_dir)
deplibs                += $(foreach mod,$(qt),-framework Qt$(mod))

# Some additional utilities are required for building Qt apps.
qt.moc                 := $(qt.root)/libexec/moc
qt.rcc                 := $(qt.root)/libexec/rcc
