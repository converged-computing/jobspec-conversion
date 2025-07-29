#!/bin/bash
#SBATCH --job-name=PREPARE-DATA
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=2000

ROOT=/data/scratch/digenovaa/Somatic-reference-free/SNV-INDELs/RF-mut-f
CM=${ROOT}/code/makefiles/create_matrix_training.mk
CONTAINER=${ROOT}/container/rf-mut-f_v2.0.sif
REL2DIR=${ROOT}/mesomics/release2/matched-t-only
cd ${REL2DIR}
singularity exec $CONTAINER make -f ${CM} all -j 10
