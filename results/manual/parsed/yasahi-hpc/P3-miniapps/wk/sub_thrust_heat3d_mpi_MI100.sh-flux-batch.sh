#!/bin/bash
#FLUX: --job-name=poi_adam
#FLUX: -c=64
#FLUX: --gpus-per-task=1
#FLUX: --queue=amdrome
#FLUX: -t=600
#FLUX: --urgency=16

export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK}'

module purge
module load openmpi/4.1.1
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
ROCR_VISIBLE_DEVICES=1,2,3 mpirun -n ${SLURM_NTASKS} ../build/miniapps/heat3d_mpi/thrust/heat3d_mpi --nx 512 --ny 512 --nz 512 --px 1 --py 1 --pz 1 --nbiter 1000 --freq_diag 0
