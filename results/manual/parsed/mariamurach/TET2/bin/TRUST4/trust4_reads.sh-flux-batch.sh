#!/bin/bash
#FLUX: --job-name=gassy-despacito-1190
#FLUX: -n=29
#FLUX: -t=10800
#FLUX: --priority=16

module load java
output=output_reads/
mkdir $output
i=$(ls trimmed/*.R1.fq.gz | awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID 'FNR == ArrayTaskID {print}')
echo $i
f=`echo $i | awk -F".R1.fq.gz" '{print $1}'`    
f1="${f}.R1.fq.gz"
f2="${f}.R2.fq.gz"
run-trust4 -t 40 \
-f GRCm38_bcrtcr.fa \
--ref mouse_IMGT+C.fa \
-1 $f1 -2 $f2 \
--outputReadAssignment \ 
-o $output/$(basename $f)
