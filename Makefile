CXX = g++
CXXFLAGS = -std=c++17 -Wall -I./Include
LDFLAGS = -lcurl

SRC_DIR = Src
INC_DIR = Include
OUT_DIR = Output
OBJ_DIR = $(OUT_DIR)/obj

CXXFLAGS += -pthread
LDFLAGS += -pthread

EXE_NAME = stock_analysis
TARGET = $(OUT_DIR)/$(EXE_NAME)

SOURCES = $(wildcard $(SRC_DIR)/*.cpp)

OBJECTS = $(SOURCES:$(SRC_DIR)/%.cpp=$(OBJ_DIR)/%.o)

HEADERS = $(wildcard $(INC_DIR)/*.h)

all: directories $(TARGET)

directories:
	@echo "[INFO] Creating necessary directories..."
	@mkdir -p $(OUT_DIR)
	@mkdir -p $(OBJ_DIR)

$(TARGET): $(OBJECTS)
	@echo "[INFO] Linking object files to create the executable..."
	@$(CXX) $(OBJECTS) -o $(TARGET) $(LDFLAGS)
	@echo "[SUCCESS] Build complete! Executable created at: $(TARGET)"

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp $(HEADERS)
	@echo "[INFO] Compiling $< -> $@"
	@$(CXX) $(CXXFLAGS) -c $< -o $@

clean:
	@echo "[INFO] Cleaning up build files..."
	@rm -rf $(OUT_DIR)
	@echo "[SUCCESS] Clean complete!"

run: all
	@echo "[INFO] Running the program..."
	@$(TARGET)

.PHONY: all clean directories run
