#!/bin/bash
IOC_PATH=~/local/data/work/hg/repos/i404
applypvs  -i $IOC_PATH/pypdb/i404.pot \
	-o $IOC_PATH/fls \
	$IOC_PATH/opi/I404.edl \
	$IOC_PATH/opi/ICGraph1.edl \
	$IOC_PATH/opi/ICGraph2.edl \
	$IOC_PATH/opi/ICGraph3.edl \
	$IOC_PATH/opi/ICGraph4.edl \
	$IOC_PATH/opi/ICs1.edl \
	$IOC_PATH/opi/ICs2.edl \
	$IOC_PATH/opi/ICs3.edl \
	$IOC_PATH/opi/ICs4.edl
