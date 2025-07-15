#!/bin/bash
#FLUX: --job-name=creamy-leader-5763
#FLUX: -N=6
#FLUX: --queue=normal
#FLUX: -t=172800
#FLUX: --urgency=16

export JULIA_WORKER_TIMEOUT='300'

module load julia/1.1.0
export JULIA_WORKER_TIMEOUT=300
rm -f nodefile
for i in `srun -n $SLURM_NTASKS hostname |sort`
do echo $i-ib0 >> nodefile
done
echo $1
echo $2
julia ../../specSmetsWout_N_MH=1_3_5.jl 96 $1 $2
