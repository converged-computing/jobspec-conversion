#!/bin/bash
#SBATCH --job-name=10x_te_process_step2
#SBATCH --account=congle
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=64G
#SBATCH --time=01:00:00
#SBATCH --array=166-166

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
