#!/bin/bash
#FLUX: --job-name=example_parallel
#FLUX: --queue=transcale
#FLUX: -t=3600
#FLUX: --urgency=16

export INTEL_LICENSE_FILE='/softs/intel/l_ics/license:$INTEL_LICENSE_FILE'

source /softs/intel/l_ics/2017_update4/compilers_and_libraries_2017.4.196/linux/bin/compilervars.sh intel64
source /softs/intel/l_ics/2017_update4/compilers_and_libraries_2017.4.196/linux/mpi/intel64/bin/mpivars.sh intel64
export INTEL_LICENSE_FILE=/softs/intel/l_ics/license:$INTEL_LICENSE_FILE
BASE=/home_nfs/lgltpe/rhys.hawkins/software/TDTWavetomo2D/
BIN=$BASE/wavetomo2dfrequencysliceinvert_pt
DATABASE=/erc_transcale/rhys.hawkins/data/
INPUT=$DATABASE/data20.txt
PRIOR=$DATABASE/prior.txt
OUTPUTBASE=/erc_transcale/rhys.hawkins/wavetomo2d
mkdir -p $OUTPUTBASE
OUTPUT=$OUTPUTBASE/example_parallel/
mkdir -p $OUTPUT
OPTIONS="-i $INPUT \
	-o $OUTPUT \
        -M $PRIOR \
	-x 6 -y 6 -w 4 \
	-s 0 \
        -n 64 -N 95.5 \
        -a 19 -A 50.5 \
        -k 500 \
        -t 10000 \
        -v 100 \
	-E \
        -c 7 \
	" 
mpirun -PSM2 -n $SLURM_NTASKS -ppn $SLURM_CPUS_ON_NODE $BIN $OPTIONS
exit
