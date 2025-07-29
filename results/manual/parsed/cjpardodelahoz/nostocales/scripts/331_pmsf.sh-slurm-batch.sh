#!/bin/bash
#SBATCH --output=log/331_pmsf.%A_%a.out
#SBATCH --error=log/331_pmsf.%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=6
#SBATCH --mem-per-cpu=8G
#SBATCH --partition=scavenger
#SBATCH --array=1-50

module load IQ-TREE/1.6.12-MPI
mpirun -np 2 iqtree-mpi -nt 6 -s analyses/phylogenomic_jackknifing/alignments/concat/331_rep${SLURM_ARRAY_TASK_ID}.phy \
 -m LG+C60+F+G4 \
 -ft analyses/phylogenomic_jackknifing/trees/331_rep${SLURM_ARRAY_TASK_ID}_guide.treefile \
 -pre .analyses/phylogenomic_jackknifing/trees/331_rep${SLURM_ARRAY_TASK_ID}_pmsf \
 -bb 1000
