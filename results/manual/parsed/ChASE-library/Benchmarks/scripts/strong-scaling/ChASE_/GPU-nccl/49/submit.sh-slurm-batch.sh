#!/bin/bash
#SBATCH --account=slai
#SBATCH --output=job.out
#SBATCH --error=job.err
#SBATCH --nodes=49
#SBATCH --ntasks=196
#SBATCH --cpus-per-task=12
#SBATCH --gres=gpu:4
#SBATCH --time=00:30:00
#SBATCH --partition=booster
#SBATCH --constraint=ntasks-per-node=4

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
