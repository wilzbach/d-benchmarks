SHELL=/bin/bash

################################################################################
# Assuming you have a folder 'looping' with the following test files:
#
# looping/
# 	main.d      (benchmark evaluator)
# 	test_1.d    (provides a test, must be annotated with `extern`)
# 	test_2.d
# 	...
#
# it then provides the following targets
#
# make looping.dmd
# make looping.ldc
# make looping.all
#
# Other targets
# -------------
#
# make all     (will run all targets)
# make clean   (removes all binaries)
################################################################################

################################################################################
# Flags
################################################################################

DMD_FLAGS=-inline -release -O -boundscheck=off
LDC_FLAGS=-release -O3 -boundscheck=off
# if gcc > 6, you can try -fbounds-check=off
GDC_FLAGS=-finline-functions -frelease -O3

################################################################################
# Compilers
################################################################################

DMD=dmd
LDC=ldc
GDC=gdc

# included in the DMD Linux release
OBJ2ASM=~/programs/dmd2/linux/bin64/obj2asm

bin/%/:
	mkdir -p $@

################################################################################
# Libraries
# ---------
#
# This is currently WIP
################################################################################

MIR_PATH=..
MIR_SOURCE=$(MIR_PATH)/source
#GFLAGS=-I$(MIR_SOURCE)

bin/dmd/libmir.a: | bin/dmd/
	$(DMD) $(DMD_FLAGS) -lib -of$@ $$(find $(MIR_SOURCE) -name '*.d')

bin/ldc/libmir.a: | bin/ldc/
	$(LDC) $(LDC_FLAGS) -lib -of$@ $$(find $(MIR_SOURCE) -name '*.d')

#DMD_LIBRARIES:=bin/dmd/libmir.a
#LDC_LIBRARIES:=bin/ldc/libmir.a

################################################################################
# Optimized object files
################################################################################

bin/dmd/%.o: %.d | bin/dmd/
	$(DMD) $(GFLAGS) $(DMD_FLAGS) -c $< -of$@

bin/ldc/%.o: %.d | bin/ldc/
	$(LDC) $(GFLAGS) $(LDC_FLAGS) -c $< -of$@

################################################################################
# Main object files (unoptimized)
################################################################################

bin/ldc/%/main.o: %/main.d | bin/ldc/
	$(LDC) $(GFLAGS) -I$(subst bin/ldc/,,$(@D)) -c $< -of$@

bin/dmd/%/main.o: %/main.d | bin/dmd/
	$(DMD) $(GFLAGS) -I$(subst bin/dmd/,,$(@D)) -c $< -of$@

################################################################################
# Assembler files
# e.g. `make bin/dmd/alias/test_1.s`
################################################################################

bin/dmd/%.s: bin/dmd/%.o
	$(OBJ2ASM) $< > $@

bin/ldc/%.s: %.d
	$(LDC) $(GFLAGS) $(LDC_FLAGS) -c -output-s $< -of$@

################################################################################
# Link to binary
################################################################################

.SECONDEXPANSION:

bin/dmd/run_%: $$(subst .d,.o, $$(addprefix bin/dmd/, $$(wildcard $$(*F)/*.d))) $(DMD_LIBRARIES)
	$(DMD) -of$@ $^

bin/ldc/run_%: $$(subst .d,.o, $$(addprefix bin/ldc/, $$(wildcard $$(*F)/*.d))) $(LDC_LIBRARIES)
	$(LDC) -of$@ $^

################################################################################
# Global targets
################################################################################

%.all: %.dmd %.ldc
	@echo

%.dmd: bin/dmd/run_%
	@echo ">dmd"
	@$<

%.ldc: bin/ldc/run_%
	@echo ">ldc"
	@$<

all: $(subst /,.all, $(filter-out bin/,$(wildcard */)))

################################################################################
# Other
################################################################################

clean:
	rm -rf bin

MAKEFLAGS += --no-builtin-rules

# Save intermediate files during development (remove for production)
.SECONDARY:
