#CC=gcc.exe
#OBJCOPY=objcopy
CC=arm-none-eabi-gcc -specs=gba.specs
OBJCOPY=arm-none-eabi-objcopy

ROOT_DIR=$(shell pwd)

SRCDIR=src
SRCDIR_TEXTURES=$(SRCDIR)/textures
BUILD_DIR=build_dir

SRC_FILES=\
	  $(SRCDIR)/main.c \
	  $(SRCDIR)/test.c

SRC_FILES_TEXTURES=\
	  $(SRCDIR_TEXTURES)/player_1.c \
	  $(SRCDIR_TEXTURES)/player_2.c \
	  $(SRCDIR_TEXTURES)/end.c \
	  $(SRCDIR_TEXTURES)/title.c \
	  $(SRCDIR_TEXTURES)/ball.c 


INCLUDE_PATH=-Iinclude
CFLAGS=-mthumb -mthumb-interwork -O3
LFLAGS=-lm -mthumb -mthumb-interwork


# Object files
# OBJ_FILES := $(SRC_FILES:.c=.o)
OBJ_FILES := $(patsubst $(SRCDIR)/%.c,$(BUILD_DIR)/%.o,$(SRC_FILES))
OBJ_TEXTURE_FILES := $(patsubst $(SRCDIR_TEXTURES)/%.c,$(BUILD_DIR)/textures/%.o,$(SRC_FILES_TEXTURES))

# Target executable
TARGET := main.gba

$(BUILD_DIR)/%.o: $(SRCDIR)/%.c
	$(CC) $(INCLUDE_PATH) $(CFLAGS) -c -o $@ $<

$(BUILD_DIR)/textures/%.o: $(SRCDIR)/textures/%.c
	$(CC) $(INCLUDE_PATH) $(CFLAGS) -c -o $@ $<


# Main target
all: $(TARGET)

$(TARGET): $(OBJ_FILES) $(OBJ_TEXTURE_FILES)
	$(CC) $(LFLAGS) $(OBJ_FILES) $(OBJ_TEXTURE_FILES) -o main.elf
	$(OBJCOPY) -O binary main.elf main.gba


clean:
	rm -rf $(BUILD_DIR)/*.o
	rm -rf $(BUILD_DIR)/textures/*.o

