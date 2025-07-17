#!/bin/bash
#FLUX: --job-name=MUGA_REF_BG_CHECKS
#FLUX: -t=14400
#FLUX: --urgency=16

config=/projects/compsci/vmp/USERS/widmas/MUGA_reference_data/data/GigaMUGA/chrs.txt
chr=$(sed "${SLURM_ARRAY_TASK_ID}q;d" ${config})
echo ${chr}
echo "Running Chromosome ${chr}"
singularity run docker://sjwidmay/muga_qc:latest code/GigaMUGA_ConsensusGenos.R ${chr}
