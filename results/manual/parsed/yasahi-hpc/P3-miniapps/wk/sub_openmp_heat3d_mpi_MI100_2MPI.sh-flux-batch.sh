#!/bin/bash
#FLUX: --job-name=bumfuzzled-motorcycle-0477
#FLUX: -c=64
#FLUX: --gpus-per-task=1
#FLUX: -t=600
#FLUX: --urgency=16

module purge
module load openmpi/4.1.1
ROCR_VISIBLE_DEVICES=1,2,3 mpirun -n ${SLURM_NTASKS} ./wrapper_amd.sh ../build/miniapps/heat3d_mpi/openmp/heat3d_mpi --px 1 --py 1 --pz 2 --nx 512 --ny 512 --nz 256 --nbiter 1000 --freq_diag 0
