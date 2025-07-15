#!/bin/bash
#FLUX: --job-name=outstanding-signal-7364
#FLUX: -n=18
#FLUX: --queue=gpu
#FLUX: -t=6900
#FLUX: --priority=16

export HDF5_USE_FILE_LOCKING='FALSE'

module load Python/3.6.6-intel-2018b
source /home/kadow/pytorch/venv/bin/activate
module load CUDA/10.0.130  
export HDF5_USE_FILE_LOCKING='FALSE'
python test.py --root /scratch/kadow/climate/hdf5/to_test --mask_root /scratch/kadow/climate/hdf5/to_test/mask --snapshot /home/kadow/pytorch/pytorch-hdf5-numpy/snapshots/20cr/ckpt/1000000.pth
