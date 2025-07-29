#!/bin/bash
#FLUX: --job-name=si-liquid
#FLUX: -t=3000
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

module purge
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
for i in `seq 0 100`
do
	srun --mpi=pmi2 \
	singularity run --nv \
     	/scratch/gpfs/ppiaggi/Simulations/QuantumEspressoGPU/quantum_espresso_qe-7.1.sif \
     	pw.x -input pw-si-$i.in -npool 2 > pw-si-$i.out
done
