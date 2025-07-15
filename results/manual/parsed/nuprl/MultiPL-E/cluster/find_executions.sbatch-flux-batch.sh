#!/bin/bash
#FLUX: --job-name=find_executions
#FLUX: -n=200
#FLUX: -c=2
#FLUX: --queue=express
#FLUX: -t=600
#FLUX: --priority=16

module load gnu-parallel
parallel="parallel -j $SLURM_NTASKS"
$parallel "srun -N1 -n1 python3 find_executions.py --host $1 --container /dataset" ::: $1/* > executions.txt
