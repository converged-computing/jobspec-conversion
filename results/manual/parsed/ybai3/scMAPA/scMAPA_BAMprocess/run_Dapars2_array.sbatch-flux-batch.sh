#!/bin/bash
#FLUX: --job-name=strawberry-eagle-5972
#FLUX: --urgency=16

module load gcc/8.2.0
module load python/anaconda2.7-4.4.0_genomics
module load bedtools/2.27.1
module load r/3.5.1
echo $SLURM_ARRAY_TASK_ID
chrSeqs=($(cat chrIDs.txt))
echo $chrSeqs
chrID=${chrSeqs[${SLURM_ARRAY_TASK_ID}]}
echo $chrID
configure=/ihome/hpark/yub20/NAR_mousebrain/BAMdedup/config.txt
echo $configure
python Dapars2_Multi_Sample_abd.py $configure $chrID
