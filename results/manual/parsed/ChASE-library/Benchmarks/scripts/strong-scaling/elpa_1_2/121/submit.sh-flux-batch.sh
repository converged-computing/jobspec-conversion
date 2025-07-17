#!/bin/bash
#FLUX: --job-name=fat-pastry-7077
#FLUX: -N=121
#FLUX: -n=484
#FLUX: --queue=develbooster
#FLUX: -t=5400
#FLUX: --urgency=16

export SRUN_CPUS_PER_TASK='${SLURM_CPUS_PER_TASK}'
export OMP_NUM_THREADS='${SRUN_CPUS_PER_TASK}'

export SRUN_CPUS_PER_TASK=${SLURM_CPUS_PER_TASK}
ml Stages/2023 GCC OpenMPI CUDA imkl CMake Boost git
export OMP_NUM_THREADS=${SRUN_CPUS_PER_TASK}
for i in {1..15}
do
srun --threads-per-core=1 ../elpa_miniapp/build/elpa.exe 115459 1200 16 ${DATA_PATH}/In2O3-115k/mat.bin
ELPA_MINIAPPS_SOLVER=1 srun --threads-per-core=1 ../elpa_miniapp/build/elpa.exe 115459 1200 16 ${DATA_PATH}/In2O3-115k/mat.bin
done
