#!/bin/bash
#FLUX: --job-name=breseq_snakemake
#FLUX: --queue=defq,sched_mem1TB
#FLUX: -t=108000
#FLUX: --urgency=16

bash snakemakeslurm.sh
echo Done!!!
