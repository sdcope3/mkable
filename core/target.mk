# Copyright (c) 2022 Stephen David Cope III. All rights reserved.

# Print the third-party dependencies defined by the active dependency set.
.PHONY: deps
deps:
	@$(call fn.print,\
		$(foreach dep,\
			$(deps),\
			$(dep)-$(call fn.resolve,$(dep),version)\
		)\
	)

# Print the build environment.
.PHONY: env
env:
	@echo os=$(os)
	@echo os_version=$(os_version)
	@echo platform=$(platform)
	@echo toolchain=$(toolchain)

# Completely blow away the build directory.
.PHONY: nuke
nuke:
	$(call fn.nuke_dir,$(build_root))
