#!/bin/bash
#FLUX: --job-name=crusty-kitty-5580
#FLUX: -N=49
#FLUX: -n=196
#FLUX: -c=12
#FLUX: --queue=booster --gres=gpu:4
#FLUX: -t=1800
#FLUX: --priority=16

export SRUN_CPUS_PER_TASK='${SLURM_CPUS_PER_TASK}'
export OMP_NUM_THREADS='${SRUN_CPUS_PER_TASK}'

export SRUN_CPUS_PER_TASK=${SLURM_CPUS_PER_TASK}
ml Stages/2023 GCC OpenMPI CUDA imkl CMake Boost git
export OMP_NUM_THREADS=${SRUN_CPUS_PER_TASK}
OPT=S
executable=../ChASE/build/examples/2_input_output/2_input_output_mgpu
for i in {1..4}
do
srun --threads-per-core=1 ${executable} --n 115459 --nev 1200 --nex 400 --path_in=${DATA_PATH}/In2O3-115k/mat.bin --complex 1 --opt ${OPT} --mode R  --deg 20 --lanczosIter 40 --numLanczos 10 --tol 1e-10
done
