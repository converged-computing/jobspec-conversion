#!/bin/bash
#FLUX: --job-name=expressive-milkshake-9439
#FLUX: --urgency=16

set -e
BASE_LOC=$PWD
DATADIR=$BASE_LOC/../tensorflow-scripts/results #where you want your data to be stored
WORKDIR=$BASE_LOC/../tensorflow-scripts
cd $WORKDIR
for QUORUM in 0.2 # 0.6
do
	for QUOTA in 20 # 20 60
	do
		python FL_in_MRS.py '../data/mixed**.dat' ${QUORUM} ${QUOTA}
	done
done
