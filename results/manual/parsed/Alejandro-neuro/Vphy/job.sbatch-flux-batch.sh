#!/bin/bash
#FLUX: --job-name=hairy-butter-5084
#FLUX: -c=4
#FLUX: --queue=general
#FLUX: -t=3600
#FLUX: --priority=16

export WANDB_API_KEY='5627524443770cf7995a564065ff75a9522b1a48'

module use /opt/insy/modulefiles
module load cuda/11.2 cudnn/11.2-8.1.1.33
echo 'conda activate vphys'
conda activate vphys
export WANDB_API_KEY="5627524443770cf7995a564065ff75a9522b1a48"
srun python Figures/init_exp.py
