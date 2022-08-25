# Copyright (c) 2022 Stephen David Cope III. All rights reserved.

####### Variables

goodbye.srcs := $(wildcard $(goodbye.root)/*.cpp)
goodbye.objs := $(addprefix $(goodbye.build_root)/,$(notdir $(goodbye.srcs:.cpp=.o)))

goodbye.depfiles := $(goodbye.objs:%.o=%.d)
-include $(goodbye.depfiles)

####### Targets

.PHONY: goodbye.clean
goodbye.clean: component = goodbye
goodbye.clean:
	$(rx.clean)

.PHONY: goodbye.lib
goodbye.lib: $(goodbye.lib)

$(goodbye.lib): $(goodbye.objs)
	$(rx.make_static_lib)

$(goodbye.build_root):
	$(rx.make_target_dir)

$(goodbye.build_root)/%.o: $(goodbye.root)/%.cpp | $(goodbye.build_root)
	$(rx.compile)
