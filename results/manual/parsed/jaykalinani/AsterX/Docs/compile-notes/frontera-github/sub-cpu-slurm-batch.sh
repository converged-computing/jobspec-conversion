#!/bin/bash
#SBATCH --job-name=qc0_X_N4
#SBATCH --account=PHY20010
#SBATCH --output=myjob.o%j
#SBATCH --error=myjob.e%j
#SBATCH --nodes=4
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00

export OMP_NUM_THREADS='28'

export OMP_NUM_THREADS=28
ml
source /.../spack/share/spack/setup-env.sh
spack load gcc@11.2.0
ppn=${SLURM_TASKS_PER_NODE%(*}
ranks=$SLURM_NTASKS
nodes=$((ranks / ppn))
echo "PPN   = $ppn"
echo "Ranks = $ranks"
ibrun ../../cactus_CarpetX-gcc qc0.par
