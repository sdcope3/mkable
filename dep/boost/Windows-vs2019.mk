# Copyright (c) 2022 Stephen David Cope III. All rights reserved.

#defines               +=
#cxxflags              +=
#incpath               +=
#lflags                +=
#libs                  +=

depincpath             += /I$(boost.inc_dir)
#deplflags             +=
deplibs                += $(foreach mod,$(boost),$(call fn.chk_seps,$(boost.lib_dir)/libboost_$(mod)-vc142-mt-gd-x64-$(boost.version_tag).lib))
