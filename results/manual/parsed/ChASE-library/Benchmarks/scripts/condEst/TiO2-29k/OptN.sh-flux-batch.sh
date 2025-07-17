#!/bin/bash
#FLUX: --job-name=chunky-gato-5239
#FLUX: -n=4
#FLUX: -c=12
#FLUX: --queue=develbooster
#FLUX: -t=5400
#FLUX: --urgency=16

export SRUN_CPUS_PER_TASK='${SLURM_CPUS_PER_TASK}'
export OMP_NUM_THREADS='${SRUN_CPUS_PER_TASK}'
export CHASE_DISPLAY_BOUNDS='1'

export SRUN_CPUS_PER_TASK=${SLURM_CPUS_PER_TASK}
ml Stages/2023 GCC OpenMPI CUDA imkl CMake Boost git
export OMP_NUM_THREADS=${SRUN_CPUS_PER_TASK}
export CHASE_DISPLAY_BOUNDS=1
OPT=N
executable=../ChASE/build/examples/2_input_output/2_input_output_mgpu
srun --threads-per-core=1 ${executable} --n 29528 --nev 2560 --nex 400 --path_in=${DATA_PATH}/TiO2-29k/gmat\ \ 1\ \ 1.bin --complex 1 --opt ${OPT} --mode R  --deg 20 --lanczosIter 40 --numLanczos 10 --tol 1e-10
