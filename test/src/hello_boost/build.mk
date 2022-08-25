# Copyright (c) 2022 Stephen David Cope III. All rights reserved.

####### Variables

hello_boost.srcs := $(wildcard $(hello_boost.root)/*.cpp)
hello_boost.objs := $(addprefix $(hello_boost.build_root)/,$(notdir $(hello_boost.srcs:.cpp=.o)))
hello_boost.exe := $(hello_boost.build_root)/hello_boost$(exe_ext)

hello_boost.depfiles := $(hello_boost.objs:%.o=%.d)
-include $(hello_boost.depfiles)

####### Targets

.PHONY: hello_boost.clean
hello_boost.clean: component = hello_boost
hello_boost.clean: $(call fn.get_clean_prereqs,hello_boost)
	$(rx.clean)

.PHONY: hello_boost.exe
hello_boost.exe: $(hello_boost.exe)

.PHONY: hello_boost.run
hello_boost.run: $(hello_boost.exe)
	$(rx.run)

$(hello_boost.exe): $(call fn.get_link_prereqs,hello_boost,objs)
	$(rx.link)

$(hello_boost.build_root):
	$(rx.make_target_dir)

$(hello_boost.build_root)/%.o: $(hello_boost.root)/%.cpp | $(hello_boost.build_root)
	$(rx.compile)
