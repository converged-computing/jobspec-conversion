#!/bin/bash
#FLUX: --job-name=gsl_big
#FLUX: --queue=long
#FLUX: -t=259200
#FLUX: --priority=16

export WANDB_API_KEY='831cb57f73367e89b34e0e6cfdb9e2d143987fcd'

source /home/mila/c/chris.emezue/gsl-env/bin/activate
module load python/3.7
module load cuda/11.1/cudnn/8.0
module load pytorch/1.8.1
export WANDB_API_KEY=831cb57f73367e89b34e0e6cfdb9e2d143987fcd
python main.py \
--graph erdos_renyi_lingauss \
--num_variables 20 \
--num_samples 100 \
--num_edges 40 \
--n_step 1 \
--batch_size 256 \
--lr 1e-6
