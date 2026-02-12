# Use your home local directory since /usr/local is read-only on Guix
PREFIX  ?= ${HOME}/.local
CC      := gcc

# Use pkg-config to find X11 paths dynamically
X11_CFLAGS := $(shell pkg-config --cflags x11)
X11_LIBS   := $(shell pkg-config --libs x11)

# Combined flags
CFLAGS  := -pedantic -Wall -Wno-deprecated-declarations -Os ${X11_CFLAGS}
LDFLAGS := ${X11_LIBS}

all: options dwmblocks

options:
	@echo dwmblocks build options:
	@echo "CFLAGS  = ${CFLAGS}"
	@echo "LDFLAGS = ${LDFLAGS}"
	@echo "CC      = ${CC}"

# Note: Added ${LDFLAGS} at the end of the command (order matters for some linkers)
dwmblocks: dwmblocks.c blocks.def.h blocks.h
	${CC} -o dwmblocks dwmblocks.c ${CFLAGS} ${LDFLAGS}

blocks.h:
	cp blocks.def.h $@

clean:
	rm -f *.o *.gch dwmblocks blocks.h

install: dwmblocks
	mkdir -p ${DESTDIR}${PREFIX}/bin
	cp -f dwmblocks ${DESTDIR}${PREFIX}/bin
	chmod 755 ${DESTDIR}${PREFIX}/bin/dwmblocks

uninstall:
	rm -f ${DESTDIR}${PREFIX}/bin/dwmblocks

.PHONY: all options clean install 
uninstall
