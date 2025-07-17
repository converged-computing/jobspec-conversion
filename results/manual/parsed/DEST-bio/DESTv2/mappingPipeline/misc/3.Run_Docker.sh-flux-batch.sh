#!/bin/bash
#FLUX: --job-name=dockerMap
#FLUX: -c=7
#FLUX: --queue=standard
#FLUX: -t=86400
#FLUX: --urgency=16

pwd
echo $SLURM_CPUS_PER_TASK 
module load singularity
sampleid=$( cat mapping.data.only.collapsed.txt  | sed '1d' | awk '{ print $1 }' | sed "${SLURM_ARRAY_TASK_ID}q;d" )
numFlies=$( cat mapping.data.only.collapsed.txt  | sed '1d' | awk '{ print $2 }' | sed "${SLURM_ARRAY_TASK_ID}q;d" )
echo $sampleid
echo $numFlies
singularity run \
/scratch/yey2sn/DEST/dest_freeze1_latest.sif \
${sampleid}/${sampleid}.joint_1.fastq \
${sampleid}/${sampleid}.joint_2.fastq \
${sampleid} \
/project/berglandlab/DEST/dest_mapped/RECENT_OUTPUTS \
--cores $SLURM_CPUS_PER_TASK \
--max-cov 0.95 \
--min-cov 4 \
--base-quality-threshold 25 \
--num-flies ${numFlies} \
--do_poolsnp \
--do_snape
echo "done"
date
