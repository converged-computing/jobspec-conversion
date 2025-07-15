#!/bin/bash
#FLUX: --job-name=creep
#FLUX: -c=2
#FLUX: --queue=normal
#FLUX: --priority=16

echo $CUDA_VISIBLE_DEVICES
mpirun -n ${SLURM_NTASKS} /lammps/lammps_kokkos2/src/lmp_kokkos_cuda_mpi -k on g ${SLURM_NTASKS} -sf kk -pk kokkos newton on neigh half binsize 7.5 $@
