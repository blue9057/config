CXX		:= g++
CC		:= gcc
LDFLAGS	:= -lm -lpthread
CFLAGS	:= -O0 -g -no-pie -I../include

TARGET	:= target-name-here

SRC		:= $(wildcard *.c) $(wildcard *.h)

$(TARGET): $(TARGET).c $(SRC:%.c) $(SRC:%.h)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $<

clean:
	rm -rf $(TARGET)

.PHONY: all clean
