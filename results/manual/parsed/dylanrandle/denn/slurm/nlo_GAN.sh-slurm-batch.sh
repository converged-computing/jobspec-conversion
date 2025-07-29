#!/bin/bash
#SBATCH --job-name=nlo_gan
#SBATCH --output=logs.out
#SBATCH --error=logs.err
#SBATCH --mail-user=jbullwinkel@fas.harvard.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=48
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=96000
#SBATCH --time=00:06:00

module load gcc/10.2.0-fasrc01
module load Anaconda3/2020.11
source activate denn
cd ../denn
echo "y" | python experiments.py --gan --pkey nlo
