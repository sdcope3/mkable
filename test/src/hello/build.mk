# Copyright (c) 2022 Stephen David Cope III. All rights reserved.

####### Component dependencies

hello.component_deps := goodbye

####### Variables

hello.srcs := $(wildcard $(hello.root)/*.cpp)
hello.objs := $(addprefix $(hello.build_root)/,$(notdir $(hello.srcs:.cpp=.o)))
hello.exe := $(hello.build_root)/hello$(exe_ext)

hello.depfiles := $(hello.objs:%.o=%.d)
-include $(hello.depfiles)

####### Targets

.PHONY: hello.clean
hello.clean: component = hello
hello.clean: $(call fn.get_clean_prereqs,hello)
	$(rx.clean)

.PHONY: hello.exe
hello.exe: $(hello.exe)

.PHONY: hello.run
hello.run: $(hello.exe)
	$(rx.run)

$(hello.exe): $(call fn.get_link_prereqs,hello,objs)
	$(rx.link)

$(hello.build_root):
	$(rx.make_target_dir)

$(hello.build_root)/%.o: component = hello
$(hello.build_root)/%.o: $(hello.root)/%.cpp | $(hello.build_root)
	$(rx.compile)
