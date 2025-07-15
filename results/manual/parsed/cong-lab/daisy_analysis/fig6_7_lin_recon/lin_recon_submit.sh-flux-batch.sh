#!/bin/bash
#FLUX: --job-name=10x_te_process_step2
#FLUX: -c=8
#FLUX: --queue=batch
#FLUX: -t=3600
#FLUX: --urgency=16

module add python/3.6.4
module add miniconda
SAMPLELIST=./lin_recon_sbmit.csv
SEED=$(awk "NR==$SLURM_ARRAY_TASK_ID" $SAMPLELIST)
char_fp=$(echo "$SEED" | cut -d$',' -f1)
out_fp=$(echo "$SEED" | cut -d$',' -f2)
algorithm=$(echo "$SEED" | cut -d$',' -f3)
prior=$(echo "$SEED" | cut -d$',' -f4)
echo $char_fp
echo $out_fp
echo $algorithm
python3.6 /home/nwhughes/Cassiopeia/reconstruct_tree.py $char_fp $out_fp $algorithm $prior
