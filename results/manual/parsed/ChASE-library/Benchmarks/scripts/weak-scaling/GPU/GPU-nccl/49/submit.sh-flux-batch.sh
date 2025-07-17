#!/bin/bash
#FLUX: --job-name=crusty-pedo-5592
#FLUX: -N=49
#FLUX: -n=196
#FLUX: -c=12
#FLUX: --queue=booster
#FLUX: -t=5400
#FLUX: --urgency=16

export SRUN_CPUS_PER_TASK='${SLURM_CPUS_PER_TASK}'
export OMP_NUM_THREADS='${SRUN_CPUS_PER_TASK}'

export SRUN_CPUS_PER_TASK=${SLURM_CPUS_PER_TASK}
export OMP_NUM_THREADS=${SRUN_CPUS_PER_TASK}
ml Stages/2023 GCC OpenMPI CUDA imkl CMake Boost git
DMAX=70
N=210000
for i in {1..4}
do
srun --threads-per-core=1 ../ChASE/build/examples/2_input_output/2_input_output_mgpu --n $N --path_in=0 --isMatGen=true --dmax=${DMAX} --nev 2250 --nex 750 --complex 0 --tol 1e-10 --opt S --deg 20 --mode R --maxIter 1
done
