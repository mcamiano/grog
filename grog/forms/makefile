SOURCEFILES= add_synonym.inp grogmethod.inp

TARGETFILES=${SOURCEFILES:.inp=.frm}

install:
	for file in $(TARGETFILES);\
	do;\
		cp $$file ../distributions;\
	done

sources:
	co -u ${SOURCEFILES}

clean:
	rm -f ${TARGETFILES}
