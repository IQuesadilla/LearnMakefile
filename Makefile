CC = gcc
CXX = g++
TARGET = main
FLAGS = 

SRCDIR = src/
INCDIR = include/
OBJDIR = obj/

rwildcard=$(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2) $(filter $(subst *,%,$2),$d))
compiler=$(strip $(filter-out .cpp. .c.,$(subst .cpp.,$(CXX),$(suffix $<).) $(subst .c.,$(CC),$(suffix $<).)))

SRC = $(call rwildcard, $(SRCDIR)/, *.cpp *.c)
OBJ = $(strip $(patsubst %.c, %.o, $(patsubst %.cpp, %.o, $(subst $(SRCDIR), $(OBJDIR), $(SRC)))))

ifneq ($(filter %.cpp,$(SRC)),)
	LD = $(CXX)
else
	LD = $(CC)
endif

all: $(TARGET)

$(TARGET): $(OBJ)
	@echo "Linking o-$(OBJDIR)"
	$(LD) -o $(TARGET) $(OBJ) $(FLAGS)

.SECONDEXPANSION:
$(OBJ): $(strip $$(filter $$(subst .o,.%,$$(subst $(OBJDIR),$(SRCDIR),$$@)),$(SRC)))
	@echo "Compiling o-$@ s-$<"
	-mkdir -p $(dir $@)
	$(call compiler) -o $@ -c $< $(FLAGS) -I $(INCDIR)/

clean:
	-rm -r $(OBJDIR)
	-rm $(TARGET)
