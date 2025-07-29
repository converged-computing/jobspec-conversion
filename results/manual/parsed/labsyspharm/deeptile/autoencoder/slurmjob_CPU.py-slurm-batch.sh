#!/bin/bash
#SBATCH --job-name=getNorm
#SBATCH --output=joboutput_%j.out
#SBATCH --error=joberrors_%j.err
#SBATCH --mail-user=hungyi_wu@g.harvard.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=20
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=8G
#SBATCH --time=00:03:00
#SBATCH --partition=priority

module load gcc/6.2.0 python/3.6.0
source /home/hw233/virtualenv/py3/bin/activate
python get_tile_normalizer.py -n 20
