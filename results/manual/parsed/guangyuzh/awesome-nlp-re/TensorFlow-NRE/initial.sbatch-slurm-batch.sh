#!/bin/bash
#SBATCH --job-name=Init_data
#SBATCH --output=logs/Init_data.out
#SBATCH --mail-user=gz612@nyu.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --mem=256GB
#SBATCH --time=2-00:00:00

module purge
module load python3/intel/3.5.3
python3 -u initial.py > logs/Init_data.log
