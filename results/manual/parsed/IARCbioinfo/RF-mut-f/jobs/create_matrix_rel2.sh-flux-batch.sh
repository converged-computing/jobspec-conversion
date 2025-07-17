#!/bin/bash
#FLUX: --job-name=PREPARE-DATA
#FLUX: -c=10
#FLUX: --queue=high_p
#FLUX: --urgency=16

ROOT=/data/scratch/digenovaa/Somatic-reference-free/SNV-INDELs/RF-mut-f
CM=${ROOT}/code/makefiles/create_matrix_training.mk
CONTAINER=${ROOT}/container/rf-mut-f_v2.0.sif
REL2DIR=${ROOT}/mesomics/release2/matched-t-only
cd ${REL2DIR}
singularity exec $CONTAINER make -f ${CM} all -j 10
