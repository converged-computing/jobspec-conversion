#!/bin/bash
#FLUX: --job-name=stream
#FLUX: -c=24
#FLUX: --queue=commons
#FLUX: -t=1800
#FLUX: --urgency=16

export CHPL_LAUNCHER='slurm-gasnetrun_ibv'
export GASNET_PHYSMEM_MAX='1G'
export CHPL_LAUNCHER_WALLTIME='00:30:00'

cd $SLURM_SUBMIT_DIR
export CHPL_LAUNCHER=slurm-gasnetrun_ibv
export GASNET_PHYSMEM_MAX=1G
export CHPL_LAUNCHER_WALLTIME=00:30:00
N=536870912
for i in 1 2 3 4 5;
do
    ./stream.baseline -nl 1 --n=$N --numTrials=10
    ./stream.gpu -nl 1 --n=$N --numTrials=10
    for ratio in 0 25 50 75 100;
    do
	./stream.hybrid -nl 1 --n=$N --numTrials=10 --CPUratio=$ratio
    done
done
