include ../smsr/MAKEINCLUDE

CURRENT_DIRECTORY=grog

PCFILES= main.pc slulisting.pc

LEXFILES=

HEADERS= ./include/slulisting.h ./grog.h

INTERMEDIATES= ${PCFILES:.pc=.c} ${PCFILES:.pc=.lis} \
	${PCFILES:.pc=.lst} ${LEXFILES:.l=.c}
OBJECTFILES= ${PCFILES:.pc=.o} ${LEXFILES:.l=.o}

SOURCEFILES= ${PCFILES} ${LEXFILES}

TARGETFILE=slulisting

#
#
#
CFLAGS = 
INCLUDE	= ./include
PCC_OPTS= include=${INCLUDE} ireclen=200 oreclen=200 
DEFS	= -Dxxx
LDFLAGS	= -bloadmap:slulisting.map

ECHO=$(ORACLE_HOME)/bin/echodo

OTHERLIBS=`cat $(ORACLE_HOME)/rdbms/lib/sysliblist`
CLIBS= -ll $(OTHERLIBS)
OLIBS	= -lsql -locic -lsqlnet -lora

PROLIBS=`if test -f $(ORACLE_HOME)/rdbms/lib/prolibs.sh ; \
		then $(SHELL) $(ORACLE_HOME)/rdbms/lib/prolibs.sh ; fi`
TTLIBS=`if test -f $(ORACLE_HOME)/rdbms/lib/ttlibs.sh ; \
		then $(SHELL) $(ORACLE_HOME)/rdbms/lib/ttlibs.sh ; fi` 
STLIBS=`if test -f $(ORACLE_HOME)/rdbms/lib/stlibs.sh ; \
		then $(SHELL) $(ORACLE_HOME)/rdbms/lib/stlibs.sh ; fi`

${TARGETFILE}: $(OBJECTFILES)
	$(CC) $(CFLAGS) -o ${TARGETFILE} \
		$(OBJECTFILES) $(PROLIBS) $(TTLIBS) $(CLIBS)

lextest: lsdb.c getpath.c
	lex lsdblex.l
	mv lex.yy.c lsdblex.c
	${CC} ${CFLAGS} -I../include -c lsdb.c 
	${CC} ${CFLAGS} -I../include -c lsdblex.c 
	${CC} ${CFLAGS} -I../include -c getpath.c
	$(CC) ${CFLAGS} -o lsdblex \
	   lsdblex.o lsdb.o getpath.o $(PROLIBS) $(TTLIBS) $(CLIBS)
	cat testinput.txt|lsdblex|more

distlist:
	@for file in ${TARGETFILE} ; \
	do \
	   echo $$file >> ${SMSRDIR}/bin/distlist.txt ; \
	done

install:
	for file in ${TARGETFILE} ; \
	do \
		${RM} ${INSTDIR}/$${file} ;  \
		${CP} $${file} ${INSTDIR} ; \
		chmod ugo+x ${INSTDIR}/$${file} ; \
	done 

rcsreport:
	@ dirname=`pwd`; \
	for file in ${SOURCEFILES} Makefile ; \
	do \
	   rlog -R -L $${dirname}/$${file} ; \
	done 

rcsget:
	for file in ${SOURCEFILES} ; \
	do \
	   ${CO} $${file}; \
	done

clean:
	${RM} ${OBJECTFILES} ${INTERMEDIATES} ${TARGETFILE}

rcp: install
	${RDEL}/${CURRENT_DIRECTORY}
	${RCPLOCAL}/${CURRENT_DIRECTORY} ${RCPREMOTE}/${CURRENT_DIRECTORY}
	${RDEL}/${REMOTEBIN}/${TARGET}
	${RCPLOCAL}/${CURRENT_DIRECTORY}/${LOCALBIN}/${TARGET} ${RCPREMOTE}/${REMOTEBIN}/${TARGET}
