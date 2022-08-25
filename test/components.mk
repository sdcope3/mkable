# Copyright (c) 2022 Stephen David Cope III. All rights reserved.

################################################################################
# Populate the component list below. Each component:
#   1. is a single directory
#   2. must have its unique id added to $(components) below
#   3. must have its component.root defined below
#   4. must have its component.build_root defined below
#   5. must contain build.mk in its component.root
#   6. may contain export.mk in its component.root
################################################################################

components := hello \
              goodbye \
              hello_boost \
              hello_opencv \
              hello_qml

# Relative path to the root of the source directory.
src_root := src

# Relative path to the root of the build directory.
build_root := build

# Define the root and build_root of each component.
$(call fn.set_component_root,$(components),$(src_root))
$(call fn.set_component_build_root,$(components),$(build_root))

# To showcase that a component root can exist in a non-standard location, the
# goodbye component is defined as subdirectory of the hello component. As such,
# its root and build_root must be explicitly set here.
$(call fn.set_component_root,goodbye,$(hello.root))
$(call fn.set_component_build_root,goodbye,$(hello.build_root))
