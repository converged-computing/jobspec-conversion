#!/bin/bash
#SBATCH --job-name=test4
#SBATCH --mail-user=shelvin.chand@csiro.au
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=20
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=20G
#SBATCH --time=2-12:00:00

module load python/3.7.2
source $(which virtualenvwrapper_lazy.sh)
workon test
python params_gp.py
