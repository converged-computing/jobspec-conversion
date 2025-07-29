#!/bin/bash
#SBATCH --job-name=SG_L4
#SBATCH --output=./logs/slurm-%j.out
#SBATCH --error=./logs/slurm_error-%j.out
#SBATCH --mail-user=hartmut.schoon@uni-oldenburg.de
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=10
#SBATCH --cpus-per-task=1
#SBATCH --time=3-00:00:00

export RUST_BACKTRACE='full'

srun="srun -n1"
parallel="parallel -N 1 --delay 0.2 -j $SLURM_NTASKS --joblog ./logs/parallel_$SLURM_JOB_ID.log"
export RUST_BACKTRACE=full
$parallel "$srun ./spinglass.sh {}" ::: {0..10}
