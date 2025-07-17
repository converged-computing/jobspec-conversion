#!/bin/bash
#FLUX: --job-name=brute
#FLUX: -N=16
#FLUX: -n=16
#FLUX: --queue=normal
#FLUX: -t=0
#FLUX: --urgency=16

export HDF5_USE_FILE_LOCKING='FALSE'
export MKL_NUM_THREADS='128'
export GOTO_NUM_THREADS='128'
export OMP_NUM_THREADS='128'

module load intel/17.0.4
module load python3/
pip3 install --user keras h5py==2.8.0
module load phdf5
export HDF5_USE_FILE_LOCKING=FALSE
export MKL_NUM_THREADS=128
export GOTO_NUM_THREADS=128
export OMP_NUM_THREADS=128
cd /work/05863/mgarciat/stampede2/AlphaTextWorld/
srun -N 1 -n 1 python3 play_remote2.py --temperature 0.4 --subtrees 100 --subtree_depth 5 --max_steps 25 --verbose 0 --min_time 5 --cpuct 0.2 &
srun -N 1 -n 1 python3 play_remote2.py --temperature 0.4 --subtrees 100 --subtree_depth 5 --max_steps 25 --verbose 0 --min_time 5 --cpuct 0.2 &
srun -N 1 -n 1 python3 play_remote2.py --temperature 0.4 --subtrees 100 --subtree_depth 5 --max_steps 25 --verbose 0 --min_time 5 --cpuct 0.2 &
srun -N 1 -n 1 python3 play_remote2.py --temperature 0.4 --subtrees 100 --subtree_depth 5 --max_steps 25 --verbose 0 --min_time 5 --cpuct 0.2 &
srun -N 1 -n 1 python3 play_remote2.py --temperature 0.4 --subtrees 100 --subtree_depth 5 --max_steps 25 --verbose 0 --min_time 5 --cpuct 0.2 &
srun -N 1 -n 1 python3 play_remote2.py --temperature 0.4 --subtrees 100 --subtree_depth 5 --max_steps 25 --verbose 0 --min_time 5 --cpuct 0.2 &
srun -N 1 -n 1 python3 play_remote2.py --temperature 0.4 --subtrees 100 --subtree_depth 5 --max_steps 25 --verbose 0 --min_time 5 --cpuct 0.2 &
srun -N 1 -n 1 python3 play_remote2.py --temperature 0.4 --subtrees 100 --subtree_depth 5 --max_steps 25 --verbose 0 --min_time 5 --cpuct 0.2 &
srun -N 1 -n 1 python3 play_remote2.py --temperature 0.4 --subtrees 100 --subtree_depth 5 --max_steps 25 --verbose 0 --min_time 5 --cpuct 0.2 &
srun -N 1 -n 1 python3 play_remote2.py --temperature 0.4 --subtrees 100 --subtree_depth 5 --max_steps 25 --verbose 0 --min_time 5 --cpuct 0.2 &
srun -N 1 -n 1 python3 play_remote2.py --temperature 0.4 --subtrees 100 --subtree_depth 5 --max_steps 25 --verbose 0 --min_time 5 --cpuct 0.2 &
srun -N 1 -n 1 python3 play_remote2.py --temperature 0.4 --subtrees 100 --subtree_depth 5 --max_steps 25 --verbose 0 --min_time 5 --cpuct 0.2 &
srun -N 1 -n 1 python3 play_remote2.py --temperature 0.4 --subtrees 100 --subtree_depth 5 --max_steps 25 --verbose 0 --min_time 5 --cpuct 0.2 &
srun -N 1 -n 1 python3 play_remote2.py --temperature 0.4 --subtrees 100 --subtree_depth 5 --max_steps 25 --verbose 0 --min_time 5 --cpuct 0.2 &
srun -N 1 -n 1 python3 play_remote2.py --temperature 0.4 --subtrees 100 --subtree_depth 5 --max_steps 25 --verbose 0 --min_time 5 --cpuct 0.2 &
srun -N 1 -n 1 python3 play_remote2.py --temperature 0.4 --subtrees 100 --subtree_depth 5 --max_steps 25 --verbose 0 --min_time 5 --cpuct 0.2
wait
