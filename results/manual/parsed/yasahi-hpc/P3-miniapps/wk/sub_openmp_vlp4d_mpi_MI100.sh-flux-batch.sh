#!/bin/bash
#FLUX: --job-name=crunchy-punk-4754
#FLUX: -c=64
#FLUX: --gpus-per-task=1
#FLUX: -t=600
#FLUX: --priority=16

module purge
module load openmpi/4.1.1
ROCR_VISIBLE_DEVICES=1,2,3 mpirun -n ${SLURM_NTASKS} ./wrapper_amd.sh ../build/miniapps/vlp4d_mpi/openmp/vlp4d_mpi --num_threads 1 --teams 1 --device 0 --num_gpus 3 --device_map 1 -f SLD10.dat
