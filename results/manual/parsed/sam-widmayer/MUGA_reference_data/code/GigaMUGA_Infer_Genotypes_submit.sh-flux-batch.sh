#!/bin/bash
#FLUX: --job-name=stinky-snack-2538
#FLUX: --urgency=16

config=/projects/compsci/vmp/USERS/widmas/MUGA_reference_data/data/GigaMUGA/chrs.txt
chr=$(sed "${SLURM_ARRAY_TASK_ID}q;d" ${config})
echo ${chr}
echo "Running Chromosome ${chr}"
singularity exec docker://sjwidmay/muga_qc:latest code/GigaMUGA_Infer_Genotypes.R ${chr}
