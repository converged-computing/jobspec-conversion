#!/bin/bash
#FLUX: --job-name=misunderstood-rabbit-3306
#FLUX: -c=6
#FLUX: --queue=develgpus
#FLUX: -t=600
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export OMP_PROC_BIND='spread'
export OMP_PLACES='threads'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export OMP_PROC_BIND=spread
export OMP_PLACES=threads
module purge
module use /usr/local/software/jureca/OtherStages
module load Stages/Devel-2019a
module load intel-para/2019a
module load LAMMPS/3Mar2020-gpukokkos
srun lmp -in in.mod.lj -k on g 4 -sf kk -pk kokkos cuda/aware off
