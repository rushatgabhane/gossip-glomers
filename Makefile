CXX = g++

# Compiler flags for MacOS. This is needed to find the Boost libraries.
# Note: The path may vary depending on your installation.
CXXFLAGS = -I. -I/opt/homebrew/include -std=c++17

# Linker flags for MacOS. This is needed to find the Boost libraries.
# Note: The path may vary depending on your installation.
LDFLAGS = -L/opt/homebrew/lib

DEBUG ?= 0
ifeq ($(DEBUG), 1)
	CXXFLAGS += -g
endif

# Libraries.
LIBS = -lboost_json

MAELSTROM_SRC = maelstrom/maelstrom.cpp
CHALLENGES = echo unique_id broadcast grow_only_counter kafka_style_log totally_available_transactions
BUILD_DIR = build

$(BUILD_DIR):
	@mkdir -p $(BUILD_DIR)

.PHONY: all clean $(CHALLENGES)

all: $(BUILD_DIR) $(CHALLENGES)

$(CHALLENGES): | $(BUILD_DIR)
	@echo "🔨 Building $@ ..."
	$(CXX) $(CXXFLAGS) $(MAELSTROM_SRC) $@/main.cpp -o $(BUILD_DIR)/$@.out $(LDFLAGS) $(LIBS)
	@echo "✅ Built $@ → $(BUILD_DIR)/$@.out"

clean:
	rm -rf $(BUILD_DIR)
	@echo "🧹 Cleaned all binaries and object files."
