# Makefile for enigma-suite

VPATH = .:tools

CC:=gcc
CFLAGS:=-Wall -W -O3 -flto
LD:=gcc
LDFLAGS:=-fomit-frame-pointer -O3 -flto -s
LIBS:=-lm

default: enigma SGT

%.o : %.c
	$(CC) -c $(CFLAGS) -c $< -o $@

charmap.o: \
charmap.c charmap.h

cipher.o: \
cipher.c global.h charmap.h key.h cipher.h

ciphertext.o: \
ciphertext.c error.h ciphertext.h

date.o: \
date.c date.h

dict.o: \
dict.c charmap.h error.h dict.h

display.o: \
display.c display.h

enigma.o: \
enigma.c global.h charmap.h cipher.h ciphertext.h dict.h \
display.h error.h hillclimb.h ic.h input.h key.h result.h \
resume_in.h resume_out.h scan.h

enigma: \
enigma.o charmap.o cipher.o ciphertext.o date.o dict.o \
display.o error.o hillclimb.o ic.o input.o key.o result.o \
resume_in.o resume_out.o scan_int.o score.o stecker.o
	$(LD) $(LDFLAGS) -oenigma enigma.o charmap.o cipher.o ciphertext.o date.o dict.o \
	display.o error.o hillclimb.o ic.o input.o key.o result.o \
	resume_in.o resume_out.o scan_int.o score.o stecker.o $(LIBS)

error.o: \
error.c error.h date.h

hillclimb.o: \
hillclimb.c cipher.h dict.h error.h global.h key.h \
result.h resume_out.h score.h stecker.h state.h hillclimb.h

ic.o: \
ic.c cipher.h global.h hillclimb.h key.h ic.h

input.o: \
input.c charmap.h error.h global.h key.h stecker.h input.h

key.o: \
key.c global.h key.h

result.o: \
result.c charmap.h date.h error.h global.h key.h result.h

resume_in.o: \
resume_in.c error.h global.h input.h key.h resume_in.h \
scan.h stecker.h

resume_out.o: \
resume_out.c charmap.h global.h key.h state.h resume_out.h

scan_int.o: \
scan_int.c scan.h

score.o: \
score.c cipher.h key.h score.h

stecker.o: \
stecker.c global.h key.h stecker.h


# =============
#  tools/SGT.c
# =============

tools/SGT: \
tools/SGT.o
	$(LD) $(LDFLAGS) -otools/SGT tools/SGT.o $(LIBS)

tools/SGT.o: \
SGT.c

clean: FORCE
	rm -f *.o *.obj tools/*.o tools/*.obj

FORCE:
