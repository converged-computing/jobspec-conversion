#!/bin/bash
#SBATCH --job-name=si-liquid
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=16G
#SBATCH --time=00:50:00
#SBATCH --constraint=ntasks-per-node=4

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
