#!/bin/bash
#SBATCH --job-name=LP2BM_NAMD
#SBATCH --account=scinet
#SBATCH --output=LP2BM_NAMD_%j.out
#SBATCH --error=LP2BM_NAMD_%j.err
#SBATCH --nodes=100
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=40

export NAMD_BIN='/scratch/s/scinet/willis2/rfp/benchmarks/NAMD_3.0b6_Source/Linux-x86_64-g++-memopt'

module load NiaEnv/2022a
module load gcc/11.3.0
module load openmpi/4.1.4+ucx-1.11.2
export NAMD_BIN=/scratch/s/scinet/willis2/rfp/benchmarks/NAMD_3.0b6_Source/Linux-x86_64-g++-memopt
$NAMD_BIN/charmrun ++p $SLURM_NTASKS $NAMD_BIN/namd3 $PWD/210stmv2fs.namd
