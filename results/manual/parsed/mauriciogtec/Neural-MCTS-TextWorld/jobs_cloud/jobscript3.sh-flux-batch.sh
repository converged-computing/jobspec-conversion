#!/bin/bash
#FLUX: --job-name=ornery-train-1773
#FLUX: --priority=16

export HDF5_USE_FILE_LOCKING='FALSE'

module load intel/17.0.4
module load python3/3.6.3
pip3 install --user keras h5py==2.8.0
module load phdf5
export HDF5_USE_FILE_LOCKING=FALSE
cd /work/05863/mgarciat/stampede2/AlphaTextWorld/
srun -N 1 -n 1 python3 play_remote.py --temperature 0.5 --subtrees 100 --subtree_depth 5 --min_time 15 &
srun -N 1 -n 1 python3 play_remote.py --temperature 0.5 --subtrees 100 --subtree_depth 5 --min_time 15
wait
