#!/bin/bash
#SBATCH --job-name=jupyter-notebook
#SBATCH --output=jupyter-notebook.%j.%N.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=04:00:00
#SBATCH --partition=compute
#SBATCH --constraint=ntasks-per-node=24

export MODULEPATH='/share/apps/compute/modulefiles/applications:$MODULEPATH'

export MODULEPATH=/share/apps/compute/modulefiles/applications:$MODULEPATH
module load anaconda
jupyter notebook --no-browser --ip=*
