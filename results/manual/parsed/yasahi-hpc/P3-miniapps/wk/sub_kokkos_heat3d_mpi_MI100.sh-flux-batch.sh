#!/bin/bash
#FLUX: --job-name=salted-parrot-0934
#FLUX: -c=64
#FLUX: --gpus-per-task=1
#FLUX: -t=600
#FLUX: --priority=16

export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK}'

module purge
module load openmpi/4.1.1
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
ROCR_VISIBLE_DEVICES=1,2,3 mpirun -n ${SLURM_NTASKS} ../build/miniapps/heat3d_mpi/kokkos/heat3d_mpi --nx 512 --ny 512 --nz 512 --px 1 --py 1 --pz 1 --nbiter 1000 --freq_diag 0 --num_threads 1 --teams 1 --device 0 --num_gpus 3 --device_map 1
