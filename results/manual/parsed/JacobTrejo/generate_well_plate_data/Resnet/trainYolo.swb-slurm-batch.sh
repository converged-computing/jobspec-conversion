#!/bin/bash
#SBATCH --job-name=orthoRes
#SBATCH --output=log/othroRes.out
#SBATCH --error=error/orthoRes.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2048
#SBATCH --time=00:24:00

echo Running
module load opence/1.5.1
echo Module loaded
python runme_four.py -e 100 -t ../data/
echo Done
