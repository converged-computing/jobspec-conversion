#!/bin/bash
#FLUX: --job-name=nuosc_12D
#FLUX: -c=252
#FLUX: --urgency=16

export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK}'

hostname
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
module purge
module load arm21/21.1
OUT=nuosc
NV="51 101 201"
DZ="0.1 0.05 0.01 0.005 0.001"
OMP="1 2 4 8 16 32 63"
OMP="1 1 2 4 8 16 32 48 64 80 96 128 252"
NV="51 101 201"
DZ="0.1"
for omp in ${OMP}; do
for nv in ${NV}; do
for dz in ${DZ}; do
    export OMP_NUM_THREADS=$((omp))
    srun --cpu-bind=v,cores ./nuosc --mu 1.0 --nv ${nv} --dz ${dz} --zmax 1024 --cfl 0.25 --ipt 1 --ko 1e-3 --ANA_EVERY_T 99 --END_STEP 20
done
done
done
echo "--- Walltime: ${SECONDS} sec."
