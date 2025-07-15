#!/bin/bash
#FLUX: --job-name=nerdy-truffle-1586
#FLUX: --urgency=16

cd ##CDIR##
echo "Running on host: " `hostname`
echo "Current working directory is now: " `pwd`
module --force purge
module load StdEnv/2020  intel/2020.1.217  openmpi/4.0.3
module load cp2k/7.1
module load matlab/2021a.1
matlab -r '##JOBNAME##' > ##JOBNAME##.optlog
echo "Job completed at `date`"
exit 0
