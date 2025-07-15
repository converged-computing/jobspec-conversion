#!/bin/bash
#FLUX: --job-name=frigid-bicycle-3515
#FLUX: -N=49
#FLUX: -n=49
#FLUX: -c=12
#FLUX: --queue=booster
#FLUX: -t=5400
#FLUX: --urgency=16

export SRUN_CPUS_PER_TASK='${SLURM_CPUS_PER_TASK}'
export OMP_NUM_THREADS='${SRUN_CPUS_PER_TASK}'
export CUDA_VISIBLE_DEVICES='0,1,2,3'

export SRUN_CPUS_PER_TASK=${SLURM_CPUS_PER_TASK}
export OMP_NUM_THREADS=${SRUN_CPUS_PER_TASK}
export CUDA_VISIBLE_DEVICES=0,1,2,3
ml Stages/2023 GCC OpenMPI CUDA imkl CMake Boost git
for i in {1..4}
do
srun --threads-per-core=1 ../ChASE/build/examples/2_input_output/2_input_output_mgpu --n 210000 --path_in=../../../../../data/matgen_m_210000_Uniform_eps_1.000000e-04_dmax_7.000000e+01.bin --nev 2250 --nex 750 --complex 0 --tol 1e-10 --opt S --deg 20 --mode R --maxIter 1
done
