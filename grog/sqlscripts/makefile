SOURCEFILES= grog.sql

TARGETFILES=${SOURCEFILES}

install:
	for file in $(TARGETFILES);\
	do \
		cp $$file ../distributions;\
	done

sources:
	co -u ${SOURCEFILES}

clean:
