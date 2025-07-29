#!/bin/bash
#SBATCH --job-name=snl_tasks_atomate
#SBATCH --account=matgen
#SBATCH --output=snl_tasks_atomate-%j.out
#SBATCH --error=snl_tasks_atomate-%j.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=4-00:00:00
#SBATCH --constraint=ntasks-per-node=10

module unload python
module unload virtualenv
module load python/3.4-anaconda
source activate /global/u1/h/huck/ph_atomate
srun -n 1 python snl_tasks_atomate.py
