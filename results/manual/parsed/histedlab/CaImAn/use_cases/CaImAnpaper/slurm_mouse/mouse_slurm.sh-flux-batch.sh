#!/bin/bash
#FLUX: --job-name=swampy-motorcycle-4600
#FLUX: --exclusive
#FLUX: --queue=ib
#FLUX: --urgency=16

srun bash -c 'KERAS_BACKEND=tensorflow CUDA_VISIBLE_DEVICES=-1 MKL_NUM_THREADS=4 OPENBLAS_NUM_THREADS=4 /mnt/xfs1/home/agiovann/anaconda3/envs/caiman_dev/bin/python /mnt/xfs1/home/agiovann/SOFTWARE/CaImAn/use_cases/CaImAnpaper/online_testing2_bk_slurm.py $SLURM_PROCID' 
