#!/bin/bash
#FLUX: --job-name=NWSimImp
#FLUX: -N=2
#FLUX: -n=2
#FLUX: -t=217800
#FLUX: --urgency=16

config=/nfs/stak/users/phatakg/ResearchCode/Sunbelt23/Code/bashScripts/config.txt
sim=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $2}' $config)
type=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $3}' $config)
module load gcc/12.2
module load R/4.2.2
Rscript ../NWSimulationGen.R ${sim} ${type}
