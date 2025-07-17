#!/bin/bash
#FLUX: --job-name=blue-train-0444
#FLUX: -n=2
#FLUX: -c=6
#FLUX: --queue=scavenger
#FLUX: --urgency=16

module load IQ-TREE/1.6.12-MPI
mpirun -np 2 iqtree-mpi -nt 6 -s analyses/phylogenomic_jackknifing/alignments/concat/331_rep${SLURM_ARRAY_TASK_ID}.phy \
 -m LG+C60+F+G4 \
 -ft analyses/phylogenomic_jackknifing/trees/331_rep${SLURM_ARRAY_TASK_ID}_guide.treefile \
 -pre .analyses/phylogenomic_jackknifing/trees/331_rep${SLURM_ARRAY_TASK_ID}_pmsf \
 -bb 1000
