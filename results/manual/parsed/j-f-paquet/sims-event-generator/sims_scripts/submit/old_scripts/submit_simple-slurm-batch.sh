#!/bin/bash
#SBATCH --job-name=test_event
#SBATCH --account=TG-PHY180035
#SBATCH --output=slurm/out-%j
#SBATCH --error=slurm/err-%j
#SBATCH --mail-user=everett.165@osu.edu
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=05:00:00
#SBATCH --partition=skx-normal
#SBATCH --constraint=ntasks-per-node=1

module load intel/18.0.2 cmake/3.7.1 gsl boost hdf5 eigen impi python3
source ../prepare_compilation_stampede2_2.sh
module list
inputdir=../input-config
job=$SLURM_JOB_ID
ntasks=1
srun run-events --nevents 1 --rankvar SLURM_PROCID --rankfmt "{:0${#ntasks}d}" --logfile $SCRATCH/$job.log --tmpdir=$SCRATCH/ --startdir=$inputdir $job.dat
