#!/bin/bash
#FLUX: --job-name=chocolate-rabbit-7973
#FLUX: -n=4
#FLUX: -c=12
#FLUX: --queue=develbooster --gres=gpu:4
#FLUX: -t=5400
#FLUX: --priority=16

export SRUN_CPUS_PER_TASK='${SLURM_CPUS_PER_TASK}'
export OMP_NUM_THREADS='${SRUN_CPUS_PER_TASK}'

export SRUN_CPUS_PER_TASK=${SLURM_CPUS_PER_TASK}
export OMP_NUM_THREADS=${SRUN_CPUS_PER_TASK}
ml Stages/2023 GCC OpenMPI CUDA imkl CMake Boost git
DMAX=10
N=30000
for i in {1..4}
do
srun --threads-per-core=1 ../ChASE/build/examples/2_input_output/2_input_output_mgpu --n $N --path_in=0 --isMatGen=true --dmax=${DMAX} --nev 2250 --nex 750 --complex 0 --tol 1e-10 --opt S --deg 20 --mode R --maxIter 1
done
