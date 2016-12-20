# Makefile for enigma-suite

VPATH = .:tools

ifeq ($(CC),icl)
#Intel Compiler

ifneq ($(arch),)
arch_=/arch:$(arch)
endif

CFLAGS:=/O2 $(arch_) /Qipo
LD:=icl
LDFLAGS:=/O2 $(arch_) /Qipo
LIBS:=
OBJ=.obj
else
#GCC

ifneq ($(arch),)
arch_:=-march=$(arch)
endif

CC:=gcc
CFLAGS:=-Wall -W -O3 $(arch_) -flto
LD:=gcc
LDFLAGS:=-fomit-frame-pointer -O3 $(arch_) -flto -s
LIBS:=-lm
OBJ=.o
endif

default: enigma SGT

%$(OBJ) : %.c
	$(CC) $(CFLAGS) -c $< -o $@

charmap$(OBJ): \
charmap.c charmap.h

cipher$(OBJ): \
cipher.c global.h charmap.h key.h cipher.h

ciphertext$(OBJ): \
ciphertext.c error.h ciphertext.h

date$(OBJ): \
date.c date.h

dict$(OBJ): \
dict.c charmap.h error.h dict.h

display$(OBJ): \
display.c display.h

enigma$(OBJ): \
enigma.c global.h charmap.h cipher.h ciphertext.h dict.h \
display.h error.h getopt.h hillclimb.h ic.h input.h key.h result.h \
resume_in.h resume_out.h scan.h

enigma: \
enigma$(OBJ) charmap$(OBJ) cipher$(OBJ) ciphertext$(OBJ) date$(OBJ) dict$(OBJ) \
display$(OBJ) error$(OBJ) getopt$(OBJ) hillclimb$(OBJ) ic$(OBJ) input$(OBJ) key$(OBJ) result$(OBJ) \
resume_in$(OBJ) resume_out$(OBJ) scan_int$(OBJ) score$(OBJ) stecker$(OBJ)
	$(LD) $(LDFLAGS) -oenigma enigma$(OBJ) charmap$(OBJ) cipher$(OBJ) ciphertext$(OBJ) date$(OBJ) dict$(OBJ) \
	display$(OBJ) error$(OBJ) getopt$(OBJ) hillclimb$(OBJ) ic$(OBJ) input$(OBJ) key$(OBJ) result$(OBJ) \
	resume_in$(OBJ) resume_out$(OBJ) scan_int$(OBJ) score$(OBJ) stecker$(OBJ) $(LIBS)

error$(OBJ): \
error.c error.h date.h

getopt$(OBJ): \
getopt.c getopt.h

hillclimb$(OBJ): \
hillclimb.c cipher.h dict.h error.h global.h key.h \
result.h resume_out.h score.h stecker.h state.h hillclimb.h

ic$(OBJ): \
ic.c cipher.h global.h hillclimb.h key.h ic.h

input$(OBJ): \
input.c charmap.h error.h global.h key.h stecker.h input.h

key$(OBJ): \
key.c global.h key.h

result$(OBJ): \
result.c charmap.h date.h error.h global.h key.h result.h

resume_in$(OBJ): \
resume_in.c error.h global.h input.h key.h resume_in.h \
scan.h stecker.h

resume_out$(OBJ): \
resume_out.c charmap.h global.h key.h state.h resume_out.h

scan_int$(OBJ): \
scan_int.c scan.h

score$(OBJ): \
score.c cipher.h key.h score.h

stecker$(OBJ): \
stecker.c global.h key.h stecker.h


# =============
#  tools/SGT.c
# =============

tools/SGT: \
SGT$(OBJ)
	$(LD) $(LDFLAGS) -otools/SGT SGT$(OBJ) $(LIBS)

SGT$(OBJ): \
tools/SGT.c

clean: FORCE
	rm -f *.o *.obj tools/*.o tools/*.obj

FORCE:
