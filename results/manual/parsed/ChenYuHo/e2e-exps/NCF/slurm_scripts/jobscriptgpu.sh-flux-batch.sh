#!/bin/bash
#FLUX: --job-name=NCF
#FLUX: -n=2
#FLUX: --queue=batch
#FLUX: -t=43200
#FLUX: --urgency=16

module load cuda/10.1.105
module load cudnn/7.5.0
module load nccl/2.4.8-cuda10.1
module load gcc/6.4.0
cd /ibex/scratch/feij/sparse_model/e2e-exps/NCF/
/ibex/scratch/feij/envgpu/bin/mpirun --tag-output -x WANDB_PROJECT=e2e_exps -x WANDB_NAME=NCF -x WANDB_ENTITY=phlix  -x WANDB_API_KEY=3c748bd8c7fcc9d54534495a1d0a10b58bb3570e -x WANDB_TAGS=ncf_test -n 2 /ibex/scratch/feij/envgpu/bin/python ncf.py --mode train --data ../../NCF/ml-20m/ --backend gloo --init tcp://127.0.0.1:22222
