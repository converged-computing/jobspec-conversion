#!/bin/bash
#SBATCH --job-name=Cylon Scaling
#SBATCH --output=%j-stdout.txt
#SBATCH --error=%j-stderr.txt
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=20

export PATH='$DIR/bin:$PATH LD_LIBRARY_PATH=$DIR/lib:$LD_LIBRARY_PATH PYTHONPATH=$DIR/lib/python3.9/site-packages'

DIR=$HOME/anaconda3/envs/cylon_dev
module load gcc-11.2.0 openmpi-4.1.4
conda activate cylon_dev
export PATH=$DIR/bin:$PATH LD_LIBRARY_PATH=$DIR/lib:$LD_LIBRARY_PATH PYTHONPATH=$DIR/lib/python3.9/site-packages
which python gcc g++
mpirun -np 20 python cylon_scaling.py -n 35000000
