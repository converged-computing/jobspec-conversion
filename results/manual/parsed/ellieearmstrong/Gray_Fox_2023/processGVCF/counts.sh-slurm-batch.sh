#!/bin/bash
#SBATCH --job-name=countGVCF
#SBATCH --output=/scratch/users/elliea/jazlyn-ellie/grayfox_2023/count.out
#SBATCH --error=/scratch/users/elliea/jazlyn-ellie/grayfox_2023/count.err
#SBATCH --mail-user=jaam@stanford.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=500MB
#SBATCH --time=02:00:00
#SBATCH --partition=normal

for f in {1..32}
do
done
