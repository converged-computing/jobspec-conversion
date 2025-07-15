#!/bin/bash
#FLUX: --job-name=art
#FLUX: --queue=shared
#FLUX: --urgency=16

echo -e "[$(date)]\nDefinition"
command=$(awk "NR==${SLURM_ARRAY_TASK_ID}" $1)
module load gcc/5.3.0 art/2016-06-05
echo $command
$command
module unload gcc/5.3.0 art/2016-06-05
