# Copyright (c) 2022 Stephen David Cope III. All rights reserved.

# The following warrants some explanation. Essentially, this logic provides a
# convenience for (crudely) passing command line options to a target:
#
#   make foo.run arg1 arg2
#
# If the very first target passed on the command line has the '.run' suffix, we
# interpret every subsequent item as an option or argument intended to be passed
# to an executable.
#
# Since make interprets command line options in three ways:
#
#   1. a target (e.g. foo.run, foo/bar/baz.o)
#   2. an option to make (e.g. --silent)
#   3. a variable assignment (e.g. foo=bar)
#
# ...we perform some hackery by creating catch-all dummy targets for every item
# after the first '.run' target.
#
# This approach is fine (and quite convenient) for simple sets of command line
# arguments. It does have several flaws worth mentioning (as make is designed
# for building, not running):
#
#   1. an argument with the same name as a target results in a warning
#   2. an argument with an equal sign is interpreted as a variable assignment
#   3. arguments with spaces do not really work; they should be avoided
#   4. an option that starts with -- must be positioned after a general --
#        example: make foo.run -- --bar
ifeq (.run,$(suffix $(firstword $(MAKECMDGOALS))))
  args := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(args):;@$(noop))
endif

# If arguments with spaces simply must be supported, uncommenting the following
# global, catch-all target is a potential solution. Doing so allows arguments
# with spaces to (awkwardly) work, but at the cost of silently ignoring mistyped
# legitimate targets. Not recommended.
#   example: make foo.run "boo\ baz"
#%:
#	@$(noop)
