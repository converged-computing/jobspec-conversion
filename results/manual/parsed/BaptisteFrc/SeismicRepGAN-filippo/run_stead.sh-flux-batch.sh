#!/bin/bash
#FLUX: --job-name=RepGAN_4
#FLUX: --queue=gpua100
#FLUX: -t=86400
#FLUX: --priority=16

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
python3 RepGAN_drive.py --nX 4000 --cuda --epochs 3000 --latentSdim 2 --latentNdim 256 --nXRepX 1 --nRepXRep 2 --nCritic 1 --nGenerator 5 --nSlayers 1 --nNlayers 1 --nClayers 1 --DxLR 0.00002 --DsLR 0.0001 --DnLR 0.0001 --DcLR 0.0001 --FxLR 0.00002 --GzLR 0.00002 --checkpoint_dir '/gpfs/workdir/colombergi/GiorgiaGAN/checkpoint/04_07c' --results_dir '/gpfs/workdir/colombergi/GiorgiaGAN/results_4'
