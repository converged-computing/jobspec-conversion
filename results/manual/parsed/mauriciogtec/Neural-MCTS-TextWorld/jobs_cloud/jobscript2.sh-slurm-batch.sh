#!/bin/bash
#SBATCH --job-name=gfull
#SBATCH --error=slurm-%j.err
#SBATCH --nodes=16
#SBATCH --ntasks=32
#SBATCH --cpus-per-task=1
#SBATCH --time=04:00:00
#SBATCH --partition=normal

export HDF5_USE_FILE_LOCKING='FALSE'

module load intel/17.0.4
module load python3/3.6.3
pip3 install --user keras h5py==2.8.0
module load phdf5
export HDF5_USE_FILE_LOCKING=FALSE
cd /work/05863/mgarciat/stampede2/AlphaTextWorld/
python3 play_remote2.py --temperature 0.5 --subtrees 100 --subtree_depth 5 --verbose 0 --min_time 15 &
python3 play_remote2.py --temperature 0.5 --subtrees 100 --subtree_depth 5 --verbose 0 --min_time 15 &
python3 play_remote2.py --temperature 0.5 --subtrees 100 --subtree_depth 5 --verbose 0 --min_time 15 &
python3 play_remote2.py --temperature 0.5 --subtrees 100 --subtree_depth 5 --verbose 0 --min_time 15 &
python3 play_remote2.py --temperature 0.5 --subtrees 100 --subtree_depth 5 --verbose 0 --min_time 15 &
python3 play_remote2.py --temperature 0.5 --subtrees 100 --subtree_depth 5 --verbose 0 --min_time 15 &
python3 play_remote2.py --temperature 0.5 --subtrees 100 --subtree_depth 5 --verbose 0 --min_time 15 &
python3 play_remote2.py --temperature 0.5 --subtrees 100 --subtree_depth 5 --verbose 0 --min_time 15 &
python3 play_remote2.py --temperature 0.5 --subtrees 100 --subtree_depth 5 --verbose 0 --min_time 15 &
python3 play_remote2.py --temperature 0.5 --subtrees 100 --subtree_depth 5 --verbose 0 --min_time 15 &
python3 play_remote2.py --temperature 0.5 --subtrees 100 --subtree_depth 5 --verbose 0 --min_time 15 &
python3 play_remote2.py --temperature 0.5 --subtrees 100 --subtree_depth 5 --verbose 0 --min_time 15 &
python3 play_remote2.py --temperature 0.5 --subtrees 100 --subtree_depth 5 --verbose 0 --min_time 15 &
python3 play_remote2.py --temperature 0.5 --subtrees 100 --subtree_depth 5 --verbose 0 --min_time 15 &
python3 play_remote2.py --temperature 0.5 --subtrees 100 --subtree_depth 5 --verbose 0 --min_time 15 &
python3 play_remote2.py --temperature 0.5 --subtrees 100 --subtree_depth 5 --verbose 0 --min_time 15 & 
python3 play_remote2.py --temperature 0.5 --subtrees 100 --subtree_depth 5 --verbose 0 --min_time 15 &
python3 play_remote2.py --temperature 0.5 --subtrees 100 --subtree_depth 5 --verbose 0 --min_time 15 &
python3 play_remote2.py --temperature 0.5 --subtrees 100 --subtree_depth 5 --verbose 0 --min_time 15 &
python3 play_remote2.py --temperature 0.5 --subtrees 100 --subtree_depth 5 --verbose 0 --min_time 15 &
python3 play_remote2.py --temperature 0.5 --subtrees 100 --subtree_depth 5 --verbose 0 --min_time 15 &
python3 play_remote2.py --temperature 0.5 --subtrees 100 --subtree_depth 5 --verbose 0 --min_time 15 &
python3 play_remote2.py --temperature 0.5 --subtrees 100 --subtree_depth 5 --verbose 0 --min_time 15 &
python3 play_remote2.py --temperature 0.5 --subtrees 100 --subtree_depth 5 --verbose 0 --min_time 15 &
python3 play_remote2.py --temperature 0.5 --subtrees 100 --subtree_depth 5 --verbose 0 --min_time 15 &
python3 play_remote2.py --temperature 0.5 --subtrees 100 --subtree_depth 5 --verbose 0 --min_time 15 &
python3 play_remote2.py --temperature 0.5 --subtrees 100 --subtree_depth 5 --verbose 0 --min_time 15 &
python3 play_remote2.py --temperature 0.5 --subtrees 100 --subtree_depth 5 --verbose 0 --min_time 15 &
python3 play_remote2.py --temperature 0.5 --subtrees 100 --subtree_depth 5 --verbose 0 --min_time 15 &
python3 play_remote2.py --temperature 0.5 --subtrees 100 --subtree_depth 5 --verbose 0 --min_time 15 &
python3 play_remote2.py --temperature 0.5 --subtrees 100 --subtree_depth 5 --verbose 0 --min_time 15 &
python3 play_remote2.py --temperature 0.5 --subtrees 100 --subtree_depth 5 --verbose 0
--min_time 15 wait
