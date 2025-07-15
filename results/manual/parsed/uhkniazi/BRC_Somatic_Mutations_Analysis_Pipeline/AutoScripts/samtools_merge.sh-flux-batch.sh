#!/bin/bash
#FLUX: --job-name=samtools-array
#FLUX: --queue=brc
#FLUX: -t=536700
#FLUX: --priority=16

module load apps/samtools/1.10.0-singularity
           number=$SLURM_ARRAY_TASK_ID
           paramfile=samtools_merge_param.txt
           merged=`sed -n ${number}p $paramfile | awk '{print $1}'`
           bamfiles=`sed -n ${number}p $paramfile | cut -f 2- -d ' '`
           # 9. Run the program.
samtools merge $merged $bamfiles
samtools index $merged
