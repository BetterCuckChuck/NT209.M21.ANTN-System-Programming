# Disable all built-in implicit rules
.SUFFIXES:
%:: %.o
%:: %.s

# Define tools
AS = as --32
LD = ld -m elf_i386

# Find all .s source files
SRCS = $(wildcard *.s)

# Create the list of executables
TARGETS = $(SRCS:.s=)

# Prevent make from automatically deleting the intermediate .o files
.SECONDARY:

# Default target
all: $(TARGETS)

# Link
%: %.o
	$(LD) -o $@ $<

# Assemble
%.o: %.s
	$(AS) -o $@ $<

# Clean
clean:
	rm -f *.o $(TARGETS)

.PHONY: all clean
