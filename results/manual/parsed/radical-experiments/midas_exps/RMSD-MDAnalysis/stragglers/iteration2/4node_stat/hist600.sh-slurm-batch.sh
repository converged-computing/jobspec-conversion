#!/bin/bash
#SBATCH --job-name=hist600
#SBATCH --account=TG-MCB090174
#SBATCH --output=hist600.out
#SBATCH --error=hist600.err
#SBATCH --mail-user=i.paraskev@rutgers.edu
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00

cd /data/03170/tg824689/BecksteinLab/scripts-DCD
source activate daskMda
python hist300.py
