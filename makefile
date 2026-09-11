CC ?= c++
CXXFLAGS ?= -O2 -Wall -Wextra -std=c++11

BUILD_DIR := build
TOSZ := $(BUILD_DIR)/TOSZ

.PHONY: all clean tools check

all: tools

tools: $(TOSZ)

$(TOSZ): tools/linux/tosz.cpp | $(BUILD_DIR)
	$(CC) $(CXXFLAGS) $< -o $@

$(BUILD_DIR):
	mkdir -p $@

check: $(TOSZ)
	$(TOSZ) 2>&1 | grep -q 'TOSZ'

clean:
	 rm -rf $(BUILD_DIR)
