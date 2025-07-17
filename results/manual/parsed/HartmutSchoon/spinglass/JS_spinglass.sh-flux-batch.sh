#!/bin/bash
#FLUX: --job-name=SG_L4
#FLUX: -n=10
#FLUX: --queue=carl.p
#FLUX: -t=259200
#FLUX: --urgency=16

export RUST_BACKTRACE='full'

srun="srun -n1"
parallel="parallel -N 1 --delay 0.2 -j $SLURM_NTASKS --joblog ./logs/parallel_$SLURM_JOB_ID.log"
export RUST_BACKTRACE=full
$parallel "$srun ./spinglass.sh {}" ::: {0..10}
