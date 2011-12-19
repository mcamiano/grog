
SUBSYSTEMS=kshscripts sqlscripts textfiles

#
# Settings
#
PUBLISHMEDIADEVICE=/dev/fd0
PUBLISHCOMMAND=tar -tvf $(PUBLISHMEDIADEVICE) 

install:
	cd  distributions; rm -rf ./*
	cwdir=`pwd`; for file in $(SUBSYSTEMS);\
	do \
		cd $$file;\
		$(MAKE) install;\
		cd  $$cwdir;\
	done
	cd distributions; \
	echo "Distribution list for GROG with checksums" > distributionlist.txt; \
	sum * >> distributionlist.txt

sources:
	cwdir=`pwd`; for file in $(SUBSYSTEMS);\
	do \
		cd $$file;\
		$(MAKE) sources;\
		cd  $$cwdir;\
	done

publish:
	$(PUBLISHCOMMAND) -C distributions ./*

clean:
	cd  distributions; rm -rf ./*
	cwdir=`pwd`; for file in $(SUBSYSTEMS);\
	do;\
		cd $$file;\
		$(MAKE) clean;\
		cd $$cwdir;\
	done

build:

help:
	@cat grogmk.man

rnotelist:
	@ls -lR  > distributions/rnotelist.txt
