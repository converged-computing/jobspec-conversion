#!/bin/bash
#SBATCH --job-name=PyAtWork
#SBATCH --mail-user=acapet@ulg.ac.be
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=20000
#SBATCH --time=05:00:00
#SBATCH --chdir=/home/ulg/mast/acapet/NEMO/azote/

source /home/ulg/mast/acapet/pyload
echo 'Running '$1
python $1
