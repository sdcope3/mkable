# Copyright (c) 2022 Stephen David Cope III. All rights reserved.

#defines               +=
#cxxflags              +=
#incpath               +=
#lflags                +=
#libs                  +=

depincpath             += /I$(opencv.inc_dir)
#deplflags             +=
deplibs                += $(call fn.chk_seps,$(opencv.lib_dir)/opencv_world$(opencv.version_tag).lib)

# Ensure dependent libraries can be found on the system path.
export PATH := $(opencv.bin_dir);$(PATH)
