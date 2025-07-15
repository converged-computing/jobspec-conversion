#!/bin/bash
#FLUX: --job-name=amber-7b
#FLUX: -N=56
#FLUX: -c=16
#FLUX: --queue=gpumid
#FLUX: --priority=16

srun python main.py --n_nodes 56 --run_wandb
