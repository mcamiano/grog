SOURCEFILES= crch.sh crcl.sh crm.sh delcl.sh delm.sh \
	describe.sh dmpc.sh dmpd.sh dmpm.sh grogexp.sh \
	install.sh showcl.sh showm.sh example.sh

TARGETFILES=${SOURCEFILES}

install:
	for file in $(TARGETFILES);\
	do \
		cp $$file ../distributions;\
	done

sources:
	co -u ${SOURCEFILES}

clean:
