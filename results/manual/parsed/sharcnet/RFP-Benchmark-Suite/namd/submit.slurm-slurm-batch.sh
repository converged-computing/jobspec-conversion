#!/bin/bash
#SBATCH --account=cc-debug
#SBATCH --output=slurm.%N.%j.out
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=0
#SBATCH --time=00:50:00
#SBATCH --constraint=ntasks-per-node=64

export NAMD_BIN='/home/ppomorsk/projects/def-ppomorsk/benchmarks/stmv/Linux-x86_64-g++-memopt'

module load StdEnv/2023 gcc/12.3 openmpi/4.1.5
export NAMD_BIN=/home/ppomorsk/projects/def-ppomorsk/benchmarks/stmv/Linux-x86_64-g++-memopt
$NAMD_BIN/charmrun ++p $SLURM_NTASKS $NAMD_BIN/namd3 20stmv2fs.namd 
