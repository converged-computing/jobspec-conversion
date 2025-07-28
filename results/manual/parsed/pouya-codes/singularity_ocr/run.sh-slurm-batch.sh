#!/bin/bash
#FLUX: --job-name=quirky-kerfuffle-4222
#FLUX: -t=669600
#FLUX: --urgency=16

singularity run --bind /projects:/projects singularity_ocr.sif -d \
"/projects/ovcare/classification/pouya/Irem/globus_mount" -o \
/projects/ovcare/classification/pouya/Irem/DOV/Results_batch_1 -l \
/projects/ovcare/classification/pouya/Irem/DOV/Label_batch_1 \
--num_workers 100
