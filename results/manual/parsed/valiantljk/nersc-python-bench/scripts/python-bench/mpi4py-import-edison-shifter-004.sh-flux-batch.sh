#!/bin/bash
#FLUX: --job-name=mpi4py-import-edison-shifter-004
#FLUX: -N=4
#FLUX: --queue=regular
#FLUX: -t=1800
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'

commit=true
module load shifter
if [ $commit = true ]; then
    shifter python /usr/local/bin/report-benchmark.py initialize
fi
export OMP_NUM_THREADS=1
output=tmp/latest-$SLURM_JOB_NAME.txt
srun shifter python /usr/local/bin/mpi4py-import.py $(date +%s) | tee $output
if [ $commit = true ]; then
    shifter python /usr/local/bin/report-benchmark.py finalize $( grep elapsed $output | awk '{ print $NF }' )
fi
