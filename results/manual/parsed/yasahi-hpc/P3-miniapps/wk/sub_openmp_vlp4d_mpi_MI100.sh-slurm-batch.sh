#!/bin/bash
#FLUX: --job-name=poi_adam
#FLUX: -n=2
#FLUX: -c=64
#FLUX: --gpus-per-task=1
#FLUX: --queue=amdrome
#FLUX: -t=600
#FLUX: --urgency=16

module purge
module load openmpi/4.1.1
ROCR_VISIBLE_DEVICES=1,2,3 mpirun -n ${SLURM_NTASKS} ./wrapper_amd.sh ../build/miniapps/vlp4d_mpi/openmp/vlp4d_mpi --num_threads 1 --teams 1 --device 0 --num_gpus 3 --device_map 1 -f SLD10.dat
