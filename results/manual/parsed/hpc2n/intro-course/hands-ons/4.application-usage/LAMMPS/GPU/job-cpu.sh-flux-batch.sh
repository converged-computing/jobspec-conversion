#!/bin/bash
#FLUX: --job-name=evasive-cherry-6934
#FLUX: --priority=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export OMP_PROC_BIND='spread '
export OMP_PLACES='threads'

ml purge > /dev/null 2>&1
ml GCC/8.3.0  OpenMPI/3.1.4
ml LAMMPS/3Mar2020-Python-3.7.4-kokkos
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export OMP_PROC_BIND=spread 
export OMP_PLACES=threads
srun lmp -in in_3.lj  > output_cpu.dat
