#!/bin/bash
#SBATCH --job-name=CNVkit
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=5000
#SBATCH --partition=low_p

g=`awk NR==${SLURM_ARRAY_TASK_ID} tumors.txt | awk '{print "SAMPLE="$1" CRAM="$2}'`
CONTAINER=/data/scratch/digenovaa/mesomics/AMPARCHITECT/aarchitect_v3.0.sif
singularity exec ${CONTAINER} make -f CNVKIT.mk  $g all
