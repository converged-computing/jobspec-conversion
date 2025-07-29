#!/bin/bash
#SBATCH --job-name=2.000-0.5511.7700.198
#SBATCH --output=log-%j.out
#SBATCH --error=log-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=256000
#SBATCH --time=2-00:00:00
#SBATCH --exclusive

cd /gpfs/scratch/payamgha/cfdRibletFramework/output/0.5511.7700.198/2.000
./allRun
