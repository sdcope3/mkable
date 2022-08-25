# Copyright (c) 2022 Stephen David Cope III. All rights reserved.

#defines               +=
#cxxflags              +=
#incpath               +=
#lflags                +=
#libs                  +=

depincpath             += -I$(opencv.inc_dir)
deplflags              += -Wl,-rpath,$(opencv.lib_dir)
deplibs                += $(foreach mod,$(opencv),$(opencv.lib_dir)/libopencv_$(mod).dylib)
