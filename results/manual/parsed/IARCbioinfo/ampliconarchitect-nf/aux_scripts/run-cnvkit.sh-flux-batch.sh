#!/bin/bash
#FLUX: --job-name="CNVkit"
#FLUX: --queue=low_p
#FLUX: --priority=16

g=`awk NR==${SLURM_ARRAY_TASK_ID} tumors.txt | awk '{print "SAMPLE="$1" CRAM="$2}'`
CONTAINER=/data/scratch/digenovaa/mesomics/AMPARCHITECT/aarchitect_v3.0.sif
singularity exec ${CONTAINER} make -f CNVKIT.mk  $g all
