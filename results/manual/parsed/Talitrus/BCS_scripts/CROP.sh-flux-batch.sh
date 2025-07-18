#!/bin/bash
#FLUX: --job-name=CROP
#FLUX: --queue=defq,short
#FLUX: -t=172800
#FLUX: --urgency=16

name1=$(sed -n "$SLURM_ARRAY_TASK_ID"p seq_list.txt)
cd ../data/seq
module load gsl/gcc/2.3
module load CROP
CROP -i macse.precluster.pick.pick.redundant.fasta -o macse.precluster.pick.pick.redundant_CROP -l 3 -u 4 -z 450 -b 850
