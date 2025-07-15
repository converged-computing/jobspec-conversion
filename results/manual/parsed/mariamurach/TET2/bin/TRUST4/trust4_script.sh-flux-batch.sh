#!/bin/bash
#FLUX: --job-name=misunderstood-destiny-9808
#FLUX: -n=32
#FLUX: -t=7200
#FLUX: --priority=16

module load java
output=bcr/output
mkdir $output
i=$(ls mapped/*.bam| awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID 'FNR == ArrayTaskID {print}')
echo $i
f=`echo $i | awk -F"Aligned.sortedByCoord.out.bam" '{print $1}'`    
run-trust4 -t 40 -f bcr/bcrtcr.fa --ref bcr/IMGT+C.fa -b $i -o $output/$(basename $f)
