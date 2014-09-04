#!/bin/bash
IOC_PATH=~/local/data/work/hg/repos/i404
applypvs  -i $IOC_PATH/pypdb/i404.pot \
	-o $IOC_PATH/fls \
	$IOC_PATH/as/req/I404.req
