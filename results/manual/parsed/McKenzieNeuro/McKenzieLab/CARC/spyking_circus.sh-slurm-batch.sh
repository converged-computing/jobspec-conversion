#!/bin/bash
#SBATCH --job-name=spyking-circus
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=64G
#SBATCH --time=10:00:00
#SBATCH --array=1

datadir="/carc/scratch/projects/mckenzie2016183/data/spikeSorting/spikeDemo"
module load parallel
module load miniconda3
module load matlab/R2022a
find $datadir -name "*.dat" | parallel --jobs $SLURM_NTASKS --joblog $SLURM_JOB_NAME.joblog --resume /carc/scratch/projects/mckenzie2016183/code/BASH/run_circus.sh {}
