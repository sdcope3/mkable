# Copyright (c) 2022 Stephen David Cope III. All rights reserved.

#defines               +=
#cxxflags              +=
#incpath               +=
#lflags                +=
#libs                  +=

depincpath             += -I$(boost.inc_dir)
#deplflags             +=
deplibs                += $(foreach mod,$(boost),$(boost.lib_dir)/libboost_$(mod).a)
