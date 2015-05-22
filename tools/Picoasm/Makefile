# picoblaze assembler - based on kpicosim
#

# PATH := $(PATH):$(ROOTDIR)/tools

# Add to debug macros - you can look at expanded source in *.o file
# CPPFLAGS += -E

# add debug symbols
CPPFLAGS += -g

CPP = g++

EXEC = picoasm

OBJS = main.o cassembler.o cinstruction.o cpicoblaze.o 

all: $(EXEC)

$(EXEC): $(OBJS)
	$(CPP) $(LDFLAGS) -o $@ $(OBJS) $(LDLIBS)

clean:
	-rm -f $(EXEC) *.elf *.gdb *.o

%.o: %.cpp
	$(CPP) -c $(CPPFLAGS) -o $@ $<
