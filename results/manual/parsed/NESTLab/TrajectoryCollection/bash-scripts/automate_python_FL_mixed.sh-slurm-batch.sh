#!/bin/bash
#SBATCH --job-name=FM0660
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=64G
#SBATCH --constraint=E5-2680

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
