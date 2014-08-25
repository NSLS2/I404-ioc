#!/bin/bash
getpvs -I /usr/lib/epics/dbd -I . \
	-o i404.pot \
	base.dbd \
	sCalcoutRecord.dbd \
	~/local/data/work/hg/repos/i404/i404App/Db/I404.template
