#!/bin/bash
#SBATCH --output=log.%a.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --time=10:00:00
#SBATCH --array=1-1000
#SBATCH --exclude=worker[001-024],worker[026-063],worker075

export LD_LIBRARY_PATH='${CONDA_PREFIX}/lib:${LD_LIBRARY_PATH}'
export OMP_NUM_THREADS='8'

export LD_LIBRARY_PATH=${CONDA_PREFIX}/lib:${LD_LIBRARY_PATH}
export OMP_NUM_THREADS=8
python run_sim.py
