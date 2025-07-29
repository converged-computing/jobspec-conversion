#!/bin/bash
#SBATCH --job-name=all_launch_dirs
#SBATCH --account=matgen
#SBATCH --output=all_launch_dirs-%j.out
#SBATCH --error=all_launch_dirs-%j.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=1

module unload python
module unload virtualenv
module load python/3.4-anaconda
module unload intel
source activate /global/u1/h/huck/ph_atomate
srun -n 1 python all_launch_dirs.py
