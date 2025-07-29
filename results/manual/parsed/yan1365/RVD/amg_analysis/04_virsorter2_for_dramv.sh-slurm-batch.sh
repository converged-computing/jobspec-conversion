#!/bin/bash
#FLUX: --job-name=virsorter2_%j
#FLUX: -n=48
#FLUX: -t=9000
#FLUX: --urgency=16

START=$SECONDS
part=${1}
cd /fs/ess/PAS0439/MING/virome/amg_analysis/complete_viruses_splited
virsorter run --seqname-suffix-off --viral-gene-enrich-off --provirus-off --prep-for-dramv -w ../dram_annotation/${part} -i complete_viruses.part_${part}.fa -j 48 all
DURATION=$(( SECONDS - START ))
echo "Completed in $DURATION seconds."
sacct -j $SLURM_JOB_ID -o JobID,AllocTRES%50,Elapsed,CPUTime,TresUsageInTot,MaxRSS
