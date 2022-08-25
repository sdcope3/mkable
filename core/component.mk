# Copyright (c) 2022 Stephen David Cope III. All rights reserved.

include $(components_file)

build_makefile_name := build.mk
export_makefile_name := export.mk

# Not every component is exported, so a missing export makefile is not fatal.
# Include export makefiles before build makefiles so the latter can reference
# the former if necessary.
-include $(foreach component,\
                   $(components),\
                   $(call fn.resolve,$(component),root)/$(export_makefile_name))

# Not every component must be built (e.g. header-only components), so a missing
# build makefile is not fatal. Include build makefiles after export makefiles so
# the former can reference the latter if necessary.
-include $(foreach component,\
                   $(components),\
                   $(call fn.resolve,$(component),root)/$(build_makefile_name))
