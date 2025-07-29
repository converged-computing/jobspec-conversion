#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=168
#SBATCH --cpus-per-task=1
#SBATCH --time=1-12:00:00
#SBATCH --partition=broadwl

module load parallel
module load hdf5
parallel --delay .2 -j $SLURM_NTASKS --joblog __$SLURM_JOB_NAME.runtask.log --resume srun --exclusive -N1 -n1 --error=/scratch/midway2/byolkim/exper3/err/$SLURM_JOB_NAME.err.{1} --output=/scratch/midway2/byolkim/exper3/out/$SLURM_JOB_NAME.out.{1} /project2/mkolar/julia-1.5.4/bin/julia experiment3.jl ${1} ${2} {1} ::: {1..1000}
