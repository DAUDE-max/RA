############################################################
# General purpose makefile
#
# Works for all simple C-projects where
# - binaries are compiled into sub-dir bin
# - binaries are created from a single c-source of the same name
# - we specify the curses library depending on the platform
#
# Note: multiple targets (binaries) in ./bin are supported
#

# Please add targets in ./bin here
TARGETS += $(BIN_DIR)/Lab1
 
#################################################
# There is no need to edit below this line
#################################################


#### Fixed variable definitions
NASM = nasm


NFLAGS = -f elf32
CFLAGS = -g -Wall
CC = gcc
RM_DIR = rm -rf
MKDIR = mkdir
SHELL = /bin/bash
BIN_DIR = bin

#### Default target
all: $(BIN_DIR) $(TARGETS)

$(BIN_DIR)/% : %.asm
	$(NASM) $(NFLAGS) $<
	$(CC) $(CFLAGS) $*.o -o $@ $(LDLIBS)

$(BIN_DIR):
	$(MKDIR) $(BIN_DIR)

.PHONY: clean
clean :
	$(RM_DIR) $(BIN_DIR)

