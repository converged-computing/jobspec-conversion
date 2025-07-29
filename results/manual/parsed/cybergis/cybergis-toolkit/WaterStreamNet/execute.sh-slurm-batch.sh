#!/bin/bash
#SBATCH --mail-user=flu8@illinois.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH --cpus-per-task=1
#SBATCH --time=3-00:00:00

module purge
module use /data/cigi/common/cigi-modules
module add GNU610
module add GPU
module load anaconda2
python -u run.py $1 $2 15
