# Copyright (c) 2022 Stephen David Cope III. All rights reserved.

###############################################################################
# This section defines some configuration that mkable expects. The default
# value for an option is commented out after that option's description.
###############################################################################

# Build in [debug|release] mode.
#build_mode := debug

# Relative path to a makefile containing component definitions. The example file
# in this faux repository contains additional information.
#components_file := components.mk

# Default dependency set. The active dependency set is the first non-empty value
# in the following list:
#   1. $(ds)
#   2. $(depset)
#   3. $(default_depset)
#default_depset := default

# Path to the root directory where external (i.e. outside the repo, via network-
# mounted storage for example) third-party dependencies live.
#dep_root_external := /opt

# Relative path to the root directory where internal (i.e. within the repo, via
# an imported Git submodule for example) third-party dependencies live.
#dep_root_internal := third_party

# Relative path to an alternate dependency set directory. Dependency sets in
# this directory are preferred over those in the standard location.
#preferred_depset_dir :=

# Include mkable from wherever it lives in the repo.
include mkable/mkable.mk

###############################################################################
# From this point forward, repository-specific configuration can be defined.
###############################################################################
