# for is_number
#
# Copyright (c) 2022 2023
#     John McCue <jmccue@jmcunx.com>
#
# Permission to use, copy, modify, and distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
#

SHELL=/bin/sh

#--- where to install
PRODUCTION=$(DESTDIR)/bin
PRODPMAN=$(DESTDIR)/man
PRODMAN=$(PRODPMAN)/man1
INCJLIB2=-I$(DESTDIR)/include  # may need to be changed for j_lib2.h location

#>>>>>>> select desired OS
#--- Linux 64 bit
WALL=-Wall -m64
ETAGS=etags
GZ=.gz
NROFF=cat
OSDESC != uname -smr
LIBJLIB2=-L$(DESTDIR)/lib64

#--- Linux 32 bit
#LINUX32#WALL=-Wall
#LINUX32#ETAGS=etags
#LINUX32#GZ=.gz
#LINUX32#NROFF=cat
#LINUX32#OSDESC != uname -smr
#LINUX32#LIBJLIB2=-L$(DESTDIR)/lib

#--- BSD 64 bit
#BSD#WALL=-Wall -m64
#BSD#ETAGS=etags
#BSD#GZ=.gz
#BSD#NROFF=cat
#BSD#OSDESC != uname -smr
#BSD#LIBJLIB2=-L$(DESTDIR)/lib

#--- BSD 32 bit
#BSD32#WALL=-Wall
#BSD32#ETAGS=etags
#BSD32#GZ=.gz
#BSD32#NROFF=cat
#BSD32#OSDESC != uname -smr
#BSD32#LIBJLIB2=-L$(DESTDIR)/lib

#--- AIX specific
#AIX#WALL=-bnoquiet
#AIX#ETAGS=true
#AIX#GZ=
#AIX#NROFF=nroff -man
#AIX#OSDESC = `uname -a`
#AIX#LIBJLIB2=-L$(DESTDIR)/lib

#--- should not have to change these
NROFF=nroff -man
CC=cc
CHMOD=chmod
CP=cp
CTAGS=ctags
ECHO=echo
GZIP=gzip
LINK=cc
LIBS=-lj_lib2
MV=mv
RM=rm -f
STRIP=strip
MKDIR=mkdir

EXE=
OBJ=.o
CFLAGS=-c $(WALL) $(INCJLIB2) -DOSTYPE="\"$(OSDESC)\""
LFLAGS=$(WALL) $(LIBJLIB2) -o is_number $(LIBS)

ALL_OBJ=is_number$(OBJ)
ALL_C=is_number.c
ALL_H=

#
# do the work
#
all:	ckenv tags $(ALL_OBJ) is_number.1$(GZ)
	$(LINK) $(LFLAGS) $(ALL_OBJ) $(LIBS)

ckenv:
	echo checking Variable DESTDIR
	test $(DESTDIR)

tags:	$(ALL_H) $(ALL_C)
	-$(CTAGS) $(ALL_H) $(ALL_C)
	-$(ETAGS) $(ALL_H) $(ALL_C)

is_number.1.gz:	is_number.1
	-$(RM) is_number.1.gz
	$(GZIP) is_number.1

is_number.1:	is_number.man
	$(NROFF) is_number.man > is_number.1

#--- AIX install(1) is odd compared to BSDs and Linux
install:	all
	-$(MKDIR) $(PRODUCTION)
	-$(MKDIR) $(PRODPMAN)
	-$(MKDIR) $(PRODMAN)
	-$(CHMOD) 755 $(PRODUCTION)
	-$(CHMOD) 755 $(PRODPMAN)
	-$(CHMOD) 755 $(PRODMAN)
	-$(STRIP) is_number
	$(CP) is_number $(PRODUCTION)/is_number
	$(CHMOD) 755 $(PRODUCTION)/is_number
	$(CP) is_number.1$(GZ) $(PRODMAN)/is_number.1$(GZ)
	$(CHMOD) 644 $(PRODMAN)/is_number.1$(GZ)

uninstall:	all
	-$(RM) $(PRODUCTION)/is_number
	-$(RM) $(PRODMAN)/is_number.1.gz
	-$(RM) $(PRODMAN)/is_number.1

clean:
	-$(RM) *$(OBJ)
	-$(RM) is_number$(EXE)
	-$(RM) is_number.1
	-$(RM) is_number.1.gz
	-$(RM) TAGS
	-$(RM) tags
	-$(RM) core
	-$(RM) *.core
	-$(RM) a.out
	-$(RM) *.pdb
	-$(RM) *.ilk
	-$(RM) *.bak

### END

