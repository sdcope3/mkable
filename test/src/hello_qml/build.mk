# Copyright (c) 2022 Stephen David Cope III. All rights reserved.

####### Variables

hello_qml.srcs := $(wildcard $(hello_qml.root)/*.cpp)

hello_qml.rccs := $(wildcard $(hello_qml.root)/*.qml)
hello_qml.qrcs := $(wildcard $(hello_qml.root)/*.qrc)
hello_qml.srcs += $(addprefix qrc_,$(notdir $(hello_qml.qrcs:.qrc=.cpp)))

hello_qml.objs := $(addprefix $(hello_qml.build_root)/,$(notdir $(hello_qml.srcs:.cpp=.o)))
hello_qml.exe := $(hello_qml.build_root)/hello_qml$(exe_ext)

hello_qml.depfiles := $(hello_qml.objs:%.o=%.d)
-include $(hello_qml.depfiles)

####### Targets

.PHONY: hello_qml.clean
hello_qml.clean: component = hello_qml
hello_qml.clean: $(call fn.get_clean_prereqs,hello_qml)
	$(rx.clean)

.PHONY: hello_qml.exe
hello_qml.exe: $(hello_qml.exe)

.PHONY: hello_qml.run
hello_qml.run: $(hello_qml.exe)
	$(rx.run)

$(hello_qml.exe): $(call fn.get_link_prereqs,hello_qml,objs)
	$(rx.link)

$(hello_qml.build_root):
	$(rx.make_target_dir)

$(hello_qml.build_root)/%.o: $(hello_qml.root)/%.cpp | $(hello_qml.build_root)
	$(rx.compile)

$(hello_qml.build_root)/qrc_%.o: $(hello_qml.build_root)/qrc_%.cpp | $(hello_qml.build_root)
	$(rx.compile)

$(hello_qml.build_root)/qrc_%.cpp: name = hello_qml
$(hello_qml.build_root)/qrc_%.cpp: $(hello_qml.root)/%.qrc $(hello_qml.rccs) | $(hello_qml.build_root)
	$(rx.rcc)
