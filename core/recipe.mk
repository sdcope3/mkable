# Copyright (c) 2022 Stephen David Cope III. All rights reserved.

###############################################################################
# This file contains several useful canned recipes and adheres to the following
# conventions:
#   1. each recipe is listed in alphabetical order
#   2. each recipe name has the prefix 'rx.' as a faux namespace
#   3. recipes that accept *named* input do so via target-specific variables
###############################################################################

# Clean the given component by removing dirs/files referenced by variables with
# conventional names:
#
#   object files
#   header dependency files (if applicable)
#   static library (if applicable)
#   executable (if applicable)
#   build directory
#
# This recipe removes the build directory as its final step. Note it does not
# *recursively* remove the build directory. So if any unexpected files remain,
# that step will fail. Use the optional 'custom_files' argument to remove them.
#   arguments:
#     [required] $(component) component
#     [optional] $(custom_files) additional files to remove
define rx.clean
@echo --- Cleaning $(component) ---
$(call fn.del_file,$(call fn.resolve,$(component),objs))
$(call fn.del_file,$(call fn.resolve,$(component),depfiles))
$(call fn.del_file,$(call fn.resolve,$(component),lib))
$(call fn.del_file,$(call fn.resolve,$(component),exe))
$(call fn.del_file,$(custom_files))
$(call fn.del_dir,$(call fn.resolve,$(component),build_root))
endef

# Do a standard compile with all the default platform options.
#
# NOTE: If $(component) is non-empty, the given component's list of component
# dependency api directories will be added to the include path. So in effect,
# the argument is required if the component *has* any component dependencies.
#
#   arguments:
#     [optional] $(component) component
define rx.compile
$(strip $(cxx.$(build_mode)) $(cxx_c) $(cxxflags) $(defines)\
        $(incpath) $(call fn.get_component_dep_includes,$(component))\
		$(cxx_o)$@ $<)
endef

# Do a standard link with all the default platform options.
define rx.link
$(strip $(link.$(build_mode)) $(lflags) $(link_o)$@ $^ $(libs))
endef

# Create a static library in the target directory.
define rx.make_static_lib
$(ar)$@ $^
endef

# Create the target directory.
define rx.make_target_dir
$(mkdir) $(call fn.chk_seps,$@)
endef

# Change to the target directory and run an executable.
#   arguments:
#     [optional] $(args) command arguments (see core/args.mk)
define rx.run
cd $(call fn.chk_seps,$(call fn.dir,$<)) &&\
$(strip $(call fn.do,./$(notdir $<)) $(args))
endef
