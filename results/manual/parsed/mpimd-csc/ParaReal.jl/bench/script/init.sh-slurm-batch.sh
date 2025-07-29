#!/bin/bash
#SBATCH --job-name=init
#SBATCH --output=%x-%j.out
#SBATCH --error=%x-%j.err
#SBATCH --mail-user=jschulze@mpi-magdeburg.mpg.de
#SBATCH --mail-type=FAIL,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:15:00
#SBATCH --partition=short

export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK:-1}'
export MKL_ENABLE_INSTRUCTIONS='AVX2'
export JULIA_PROJECT='@.'

set -e
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK:-1}
export MKL_ENABLE_INSTRUCTIONS=AVX2
export JULIA_PROJECT=@.
module load apps/julia/1.6
julia -e 'using Pkg; Pkg.instantiate()'
