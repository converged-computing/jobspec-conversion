#!/bin/bash
#FLUX: --job-name=RepGAN_4
#FLUX: --queue=gpua100
#FLUX: -t=86400
#FLUX: --urgency=16

export thisuser='$(whoami)'
export hmd='/gpfs/users'
export wkd='/gpfs/workdir'
export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/gpfs/users/colombergi/.conda/envs/tf/lib'

export thisuser=$(whoami)
export hmd="/gpfs/users"
export wkd="/gpfs/workdir"
module purge
module load anaconda3/2021.05/gcc-9.2.0
module load cuda/11.4.0/gcc-9.2.0
source activate tf
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/gpfs/users/colombergi/.conda/envs/tf/lib
python3 post_processing.py --nX 4000 --cuda --epochs 2000 --latentSdim 64 --latentNdim 64 --nXRepX 1 --nRepXRep 5 --nCritic 1 --nGenerator 1 --σs2 'softplus' --checkpoint_dir '/gpfs/workdir/colombergi/GiorgiaGAN/checkpoint/11_06c' --results_dir '/gpfs/workdir/colombergi/GiorgiaGAN/results_4'
