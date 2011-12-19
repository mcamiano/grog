include ${HOME}/rel3.0/MAKEINCLUDE

CURRENT_DIRECTORY=grog

PCFILES= main.pc slulisting.pc 

LEXFILES=

HEADERS = include/slulisting.h grog.h

INTERMEDIATES= ${PCFILES:.pc=.c} ${PCFILES:.pc=.lis} \
	${PCFILES:.pc=.lst} ${LEXFILES:.l=.c}
OBJECTFILES= ${PCFILES:.pc=.o} ${LEXFILES:.l=.o}

SOURCEFILES= ${PCFILES} ${LEXFILES}

TARGETFILE=slulisting

#
#
#
CCFLAGS =  -I./
CFLAGS=
INCLUDE	= ./include
PCC_OPTS= include=${INCLUDE} include=./ ireclen=200 oreclen=200 
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

install:

slulisting.o: slulisting.pc

slulisting.pc:
	rm -f slulisting.pc slulisting.c
	ln src/slulisting.pc ./

rcsget:
	for file in ${SOURCEFILES} ; \
	do \
	   ${CO} $${file}; \
	done

classexport:
	@grogexp

clean:
	${RM} ${OBJECTFILES} ${INTERMEDIATES} ${TARGETFILE}
