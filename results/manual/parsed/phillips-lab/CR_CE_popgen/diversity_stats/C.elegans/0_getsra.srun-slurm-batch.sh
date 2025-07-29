#!/bin/bash
#FLUX: --job-name=sra
#FLUX: --queue=phillips
#FLUX: -t=36000
#FLUX: --urgency=16

module load easybuild sratoolkit/2.8.2-1
SRA=$(sed -n $((${SLURM_ARRAY_TASK_ID}+1))p SRA.txt)
fastq-dump --split-files $SRA
