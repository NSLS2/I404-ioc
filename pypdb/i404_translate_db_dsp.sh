#!/bin/bash
IOC_PATH=~/local/data/work/hg/repos/i404
applypvs  -i $IOC_PATH/pypdb/dsp.pot \
	-o $IOC_PATH/fls \
	$IOC_PATH/i404App/Db/dsp.db
