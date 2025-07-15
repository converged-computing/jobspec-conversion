#!/bin/bash
#FLUX: --job-name=M3F
#FLUX: -c=4
#FLUX: -t=240
#FLUX: --priority=16

source /etc/profile ; 
module load julia/1.4.2
module load gurobi/gurobi-811
julia src/main.jl --end-id 23 --val 9 --past 3 --num-past 3 --rho 0.1 --train_test_split 0.45 --rho_V 1 --data M3F${SLURM_ARRAY_TASK_ID} 
