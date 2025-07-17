#!/bin/bash
#FLUX: --job-name=mobillama
#FLUX: -N=20
#FLUX: -c=14
#FLUX: --queue=<partition>
#FLUX: -t=259200
#FLUX: --urgency=16

srun python main_mobillama.py --n_nodes 20 --run_wandb
