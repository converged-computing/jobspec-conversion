#!/bin/bash
#FLUX: --job-name=cufflinks_0
#FLUX: -t=345600
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
ulimit -s unlimited
module use /work/GIF/software/modules
module use /work/GIF/software/modules
module use /opt/rit/spack-modules/lmod/linux-rhel7-x86_64/Core
module use /opt/rit/spack-modules/lmod/linux-rhel7-x86_64/gcc
module load samtools
module load cufflinks
cufflinks -o merged_better_and_best -p 16 --multi-read-correct --frag-bias-correct TAIR10_chr_all.fas merged_better_and_best.bam
scontrol show job $SLURM_JOB_ID
