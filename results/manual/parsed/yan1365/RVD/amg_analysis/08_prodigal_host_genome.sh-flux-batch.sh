#!/bin/bash
#FLUX: --job-name=prodigal_%j
#FLUX: -n=48
#FLUX: -t=3600
#FLUX: --priority=16

module load python/3.6-conda5.2
source activate prodigal-2.6.3 
START=$SECONDS
dataset=${1}
cd /fs/ess/PAS0439/MING/virome/amg_analysis/AMG_host_metabolism/host_genome/${dataset}
for f in *.fna;
do 
prodigal -i ${f}  -a prodigal/${f%.fna}.faa
done
DURATION=$(( SECONDS - START ))
echo "Completed in $DURATION seconds."
sacct -j $SLURM_JOB_ID -o JobID,AllocTRES%50,Elapsed,CPUTime,TresUsageInTot,MaxRSS
