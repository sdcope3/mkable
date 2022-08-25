# Copyright (c) 2022 Stephen David Cope III. All rights reserved.

# Assume the repository root from the top level makefile.
repo_root := $(dir $(firstword $(MAKEFILE_LIST)))

# Assume the mkable root from this makefile.
mkable_root := $(dir $(lastword $(MAKEFILE_LIST)))

# Cache internal mkable directories for use downstream.
mkable_core_dir := $(mkable_root)core
mkable_dep_dir := $(mkable_root)dep
mkable_depset_dir := $(mkable_root)depset
mkable_env_dir := $(mkable_root)env

# Import functions here so they can be used from this point on.
include $(mkable_core_dir)/function.mk

# Remove trailing directory separators from these for consistency.
repo_root := $(call fn.rm_trailing_sep,$(repo_root))
mkable_root := $(call fn.rm_trailing_sep,$(mkable_root))

# Set default configuration values.
build_mode := $(or $(firstword $(build_mode)),debug)
components_file := $(or $(firstword $(components_file)),components.mk)
default_depset := $(or $(firstword $(default_depset)),default)
dep_root_external := $(or $(firstword $(dep_root_external)),/opt)
dep_root_internal := $(or $(firstword $(dep_root_internal)),third_party)

# Determine the active dependency set.
depset := $(or $(ds),$(or $(depset),$(or $(default_depset))))
depset_makefile := $(mkable_depset_dir)/$(depset).mk

# Check for a preferred dependency set directory.
ifneq ($(preferred_depset_dir),)
  preferred_depset_dir := $(repo_root)/$(preferred_depset_dir)
  ifneq ($(wildcard $(preferred_depset_dir)/$(depset).mk),)
    depset_makefile := $(preferred_depset_dir)/$(depset).mk
  endif
endif

# Ensure the active dependency set can be found.
ifeq ($(wildcard $(depset_makefile)),)
$(error Unknown dependency set: $(depset))
endif

# Configuration is done; include the rest of mkable.
include $(mkable_env_dir)/env.mk
include $(mkable_core_dir)/args.mk
include $(mkable_core_dir)/recipe.mk
include $(mkable_core_dir)/target.mk

# Include the active dependency set before including component definitions so
# so the latter can reference any dependency-specific configuration if needed.
include $(depset_makefile)

# Finally, include all component definitions.
include $(mkable_core_dir)/component.mk
