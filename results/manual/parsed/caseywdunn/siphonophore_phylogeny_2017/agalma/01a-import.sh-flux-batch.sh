#!/bin/bash
#FLUX: --job-name=butterscotch-lemon-9282
#FLUX: -c=12
#FLUX: -t=21600
#FLUX: --urgency=16

export AGALMA_DB='/gpfs/data/cdunn/analyses/agalma-siphonophora-20170501_reduced.sqlite'
export BIOLITE_RESOURCES='threads=${SLURM_CPUS_ON_NODE},memory=${SLURM_MEM_PER_NODE}M'

sleep $((SLURM_ARRAY_TASK_ID*60))
set -e
export AGALMA_DB="/gpfs/data/cdunn/analyses/agalma-siphonophora-20170501_reduced.sqlite"
export BIOLITE_RESOURCES="threads=${SLURM_CPUS_ON_NODE},memory=${SLURM_MEM_PER_NODE}M"
IDS=(
	dbEST_CLYHEM
	NCBI_HYDMAG
	JGI_NEMVEC
)
ID=${IDS[$SLURM_ARRAY_TASK_ID-1]}
echo $ID
agalma import --id $ID
agalma translate --id $ID
