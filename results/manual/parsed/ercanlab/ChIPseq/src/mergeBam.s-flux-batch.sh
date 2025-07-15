#!/bin/bash
#FLUX: --job-name=mergeBam
#FLUX: -t=1800
#FLUX: --priority=16

module purge
module load samtools/intel/1.6
module load bedtools/intel/2.27.1
val=$SLURM_ARRAY_TASK_ID
params=$(sed -n ${val}p forMerge.txt)
bamfiles=($params)
mergedBam=${bamfiles[0]}
printf "Merging ${bamfiles[*]:1} into $mergedBam\n"
samtools merge $mergedBam ${bamfiles[*]:1}
printf "Converting $mergedBam from BAM to BED\n"
bedtools bamtobed -i $mergedBam > ${mergedBam}.bed
exit 0;
