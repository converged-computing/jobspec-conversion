#!/bin/bash
#FLUX: --job-name=dram
#FLUX: -c=10
#FLUX: --queue=standard
#FLUX: -t=172800
#FLUX: --priority=16

echo $SLURM_JOB_NODELIST
echo ${SLURM_ARRAY_TASK_ID}
echo start
bash /scratch/kwigg_root/kwigg/hegartyb/SnakemakeAssemblies3000/CompetitiveMapping/Scripts/DRAM.sh ${SLURM_ARRAY_TASK_ID}
echo done
