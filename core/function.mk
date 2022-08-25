# Copyright (c) 2022 Stephen David Cope III. All rights reserved.

###############################################################################
# This file contains several utility functions and adheres to the following
# conventions:
#   1. each function is listed in alphabetical order
#   2. each function name has the prefix 'fn.' as a faux namespace
#   3. each function returns no extraneous whitespace (output is stripped)
###############################################################################

# Convert a leading Unix-style path separator to Windows-style.
#   arguments:
#     [required] $(1) path
#   return:
#     example (if running on Windows):
#       ./foo -> .\foo
fn.chk_leading_sep = $(strip \
  $(if $(filter $(os),Windows),\
    $(patsubst ./%,.\\%,$(1)),\
    $(1)\
  )\
)

# Convert Unix-style path separators to Windows-style.
#   arguments:
#     [required] $(1) path(s)
#   return:
#     the given path(s) with forward slashes converted to backslashes
fn.chk_seps = $(strip \
  $(if $(filter $(os),Windows),\
    $(subst /,\,$(1)),\
    $(1)\
  )\
)

# Compose a list of variables by appending the given member to each given owner
# following the 'owner.member' convention used throughout mkable.
#   arguments:
#     [required] $(1) owner(s)
#     [required] $(2) member
#   return:
#     example:
#       dep1 dep2,clean -> dep1.clean dep2.clean
fn.compose = $(strip \
  $(addsuffix .$(firstword $(2)),$(1))\
)

# Copy the given file (if it exists) to the given destination.
#   arguments:
#     [required] $(1) src
#     [required] $(2) dest
#   return:
#     the full OS-specific copy command to run
fn.copy_file = $(strip \
  $(call fn.do_if_exists,$(cp),$(1),$(call fn.chk_seps,$(2))) \
)

# Delete the the given directory if it exists.
#   arguments:
#     [required] $(1) directory
#   return:
#     the full OS-specific delete command to run
fn.del_dir = $(strip \
  $(call fn.do_if_exists,$(del_dir),$(1))\
)

# Delete the the given file if it exists.
#   arguments:
#     [required] $(1) file
#   return:
#     the full OS-specific delete command to run
fn.del_file = $(strip \
  $(call fn.do_if_exists,$(del_file),$(1))\
)

# Get the directory portion of the given path(s) without a trailing slash.
#   arguments:
#     [required] $(1) path(s)
#   return:
#     the directory portion(s) of the given path(s) minus a trailing slash
fn.dir = $(strip \
  $(foreach path,\
    $(1),\
    $(call fn.rm_trailing_sep,$(dir $(path)))\
  )\
)

# Perform an operation on a set of dirs/files whether they exist or not.
#   arguments:
#     [required] $(1) op to perform
#     [required] $(2) dirs/files
#   return:
#     the full OS-specific command to run
fn.do = $(strip \
  $(call fn.chk_leading_sep,$(1)) $(call fn.prune,$(2))\
)

# Perform an operation on a dir/file if the given dir/file exists.
#   arguments:
#     [required] $(1) op to perform
#     [required] $(2) dir/file
#     [optional] $(3) additional args
#   return:
#     the full OS-specific command to run
fn.do_if_exists = $(strip \
  $(if $(wildcard $(2)),\
    $(call fn.chk_leading_sep,$(1)) $(call fn.prune,$(wildcard $(2))) $(3)\
  )\
)

# Return the prerequisites for cleaning the given component.
#   arguments:
#     [required] $(1) component
#   return:
#     example:
#       foo -> dep1.clean dep2.clean
fn.get_clean_prereqs = $(strip \
  $(call fn.compose,$(call fn.get_component_deps,$(1)),clean)\
)

# Return the include paths for compiling the given component.
#   arguments:
#     [required] $(1) component
#   return:
#     example:
#       foo -> -Ipath/to/dep1/api -Ipath/to/dep2/api
fn.get_component_dep_includes = $(strip \
  $(foreach dir,\
    $(call fn.resolve,$(call fn.get_component_deps,$(1)),api),\
    $(cxx_I)$(dir)\
  )\
)

# Return the static libraries for linking the given component.
#   arguments:
#     [required] $(1) component
#   return:
#     example:
#       foo -> path/to/libdep1_static.a path/to/libdep2_static.a
fn.get_component_dep_libs = $(strip \
  $(call fn.resolve,$(call fn.get_component_deps,$(1)),lib)\
)

# Return the given component's component dependencies.
#   arguments:
#     [required] $(1) component
#   return:
#     example:
#       foo -> dep1 dep2
fn.get_component_deps = $(strip \
  $(call fn.resolve,$(1),component_deps)\
)

# Return the link prerequisites for an executable. Optionally specify an entry
# point to be included as well.
#   arguments:
#     [required] $(1) component
#     [required] $(2) [lib|objs|objs_no_main] link target(s)
#     [optional] $(3) entry point name
#   return:
#     examples:
#       foo,objs      -> /path/to/foo/obj1.o /path/to/foo/obj2.o\
#                        /path/to/dep1/dep1.lib /path/to/dep2/dep2.lib
#       foo,lib       -> /path/to/foo/foo.lib\
#                        /path/to/dep1/dep1.lib /path/to/dep2/dep2.lib
#       foo,objs,main -> /path/to/foo/main.o\
#                        /path/to/foo/obj1.o /path/to/foo/obj2.o\
#                        /path/to/dep1/dep1.lib /path/to/dep2/dep2.lib
fn.get_link_prereqs = $(strip \
  $(if $(strip $(3)),\
    $(call fn.resolve,$(1),build_root)/$(3).o $(call fn.get_link_prereqs,$(1),$(2)),\
    $(call fn.resolve,$(1),$(2)) $(call fn.get_component_dep_libs,$(1))\
  )\
)

# Delete the the given directory and all of its contents if it exists.
#   arguments:
#     [required] $(1) directory
#   return:
#     the full OS-specific delete command to run
fn.nuke_dir = $(strip \
  $(call fn.do_if_exists,$(nuke),$(1))\
)

# Echo the given string. If the given string is blank, echo an empty string in
# a platform-specific manner.
#   arguments:
#     [required] $(1) string
#   return:
#     the full OS-specific echo command to run
fn.print = $(strip \
  $(if $(strip $(1)),\
    echo $(1),\
    $(echo_empty)\
  )\
)

# Prune the given path(s) for use in system calls.
#   arguments:
#     [required] $(1) path(s)
#   return:
#     example (if running on Windows):
#       path/to/foo/ -> path\to\foo
fn.prune = $(strip \
  $(foreach path,\
    $(1),\
    $(call fn.chk_seps,$(call fn.rm_trailing_sep,$(path)))\
  )\
)

# Compose then resolve the list of variables defined by each given owner and
# each given member.
#   arguments:
#     [required] $(1) owner(s)
#     [required] $(2) member
#   return:
#     example:
#       dep1 dep2,lib -> $(dep1.lib) $(dep2.lib)
fn.resolve = $(strip \
  $(foreach var,\
    $(call fn.compose,$(1),$(2)),\
    $($(var))\
  )\
)

# Remove a trailing slash from the given path if one exists.
#   arguments:
#     [required] $(1) path
#   return:
#     the path minus the trailing slash (if any)
fn.rm_trailing_sep = $(strip \
  $(patsubst %/,%,$(patsubst %\,%,$(1)))\
)

# Set the build root of the given component(s).
#   arguments:
#     [required] $(1) component(s)
#     [required] $(2) build root
#   return:
#     none
fn.set_component_build_root = $(strip \
  $(foreach component,$(1),\
    $(eval $(component).build_root := $(2)/$(component))\
  )\
)

# Set the root of the given component(s).
#   arguments:
#     [required] $(1) component(s)
#     [required] $(2) root
#   return:
#     none
fn.set_component_root = $(strip \
  $(foreach component,$(1),\
    $(eval $(component).root := $(2)/$(component))\
  )\
)

# Platform-agnostic way to convert A-Z to a-z. Crude but sufficient.
#   arguments:
#     [required] $(1) string
#   return:
#     the string with A-Z converted to a-z
fn.to_lower = $(subst A,a,$(subst B,b,$(subst C,c,$(subst D,d,$(subst E,e,$(subst F,f,$(subst G,g,$(subst H,h,$(subst I,i,$(subst J,j,$(subst K,k,$(subst L,l,$(subst M,m,$(subst N,n,$(subst O,o,$(subst P,p,$(subst Q,q,$(subst R,r,$(subst S,s,$(subst T,t,$(subst U,u,$(subst V,v,$(subst W,w,$(subst X,x,$(subst Y,y,$(subst Z,z,$(1)))))))))))))))))))))))))))

# Platform-agnostic way to convert a-z to A-Z. Crude but sufficient.
#   arguments:
#     [required] $(1) string
#   return:
#     the string with a-z converted to A-Z
fn.to_upper = $(subst a,A,$(subst b,B,$(subst c,C,$(subst d,D,$(subst e,E,$(subst f,F,$(subst g,G,$(subst h,H,$(subst i,I,$(subst j,J,$(subst k,K,$(subst l,L,$(subst m,M,$(subst n,N,$(subst o,O,$(subst p,P,$(subst q,Q,$(subst r,R,$(subst s,S,$(subst t,T,$(subst u,U,$(subst v,V,$(subst w,W,$(subst x,X,$(subst y,Y,$(subst z,Z,$(1)))))))))))))))))))))))))))
