# Copyright (c) 2022 Stephen David Cope III. All rights reserved.

ifneq ($(filter $(deps),opencv),)
$(error Cannot include OpenCV more than once)
endif

ifeq ($(opencv.version),)
$(error Cannot include OpenCV without specifying a version)
endif

ifeq ($(opencv),)
$(error Cannot include OpenCV without specifying any modules)
endif

deps                   += opencv
opencv.root            := $(dep_root_external)/OpenCV/$(opencv.version)
opencv.bin_dir         := $(opencv.root)/bin
opencv.inc_dir         := $(opencv.root)/include/opencv4
opencv.lib_dir         := $(opencv.root)/lib

defines                += $(cxx_D)$(D_prefix)OPENCV_ENABLED=1\
                          $(cxx_D)$(D_prefix)OPENCV_VERSION=$(opencv.version)

include $(mkable_dep_dir)/opencv4/$(os)-$(toolchain).mk
