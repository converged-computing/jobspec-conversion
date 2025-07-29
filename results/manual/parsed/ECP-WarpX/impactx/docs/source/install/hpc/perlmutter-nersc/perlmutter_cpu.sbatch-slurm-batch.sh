#!/bin/bash
#SBATCH --job-name=ImpactX
#SBATCH --account=<proj>
#SBATCH --output=ImpactX.o%j
#SBATCH --error=ImpactX.e%j
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --partition=regular
#SBATCH: --exclusive
#SBATCH --constraint=cpu,ntasks-per-node=16

export SRUN_CPUS_PER_TASK='16  # 8 cores per chiplet, 2x SMP'
export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'

EXE=./impactx
INPUTS=inputs_small
export SRUN_CPUS_PER_TASK=16  # 8 cores per chiplet, 2x SMP
export OMP_PLACES=threads
export OMP_PROC_BIND=spread
srun --cpu-bind=cores \
  ${EXE} ${INPUTS} \
  > output.txt
