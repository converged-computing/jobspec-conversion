#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=97
#SBATCH --cpus-per-task=1
#SBATCH --time=2-22:00:00

export PATH='<your path>:$PATH'

export PATH=<your path>:$PATH
mpirun -n 97 python main-parallel-cc.py
