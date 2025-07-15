#!/bin/bash
#FLUX: --job-name=nerdy-leader-6092
#FLUX: -c=12
#FLUX: --queue=devel
#FLUX: -t=600
#FLUX: --priority=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export OMP_PROC_BIND='spread'
export OMP_PLACES='threads'

module purge
module use /usr/local/software/jureca/OtherStages
module load Stages/Devel-2019a
module load intel-para/2019a
module load LAMMPS/3Mar2020-Python-3.6.8-kokkos
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export OMP_PROC_BIND=spread
export OMP_PLACES=threads
srun lmp -in in.rhodo -k on t $OMP_NUM_THREADS -sf kk
