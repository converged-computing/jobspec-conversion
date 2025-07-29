#!/bin/bash
#SBATCH --job-name=cs3730-repeat
#SBATCH --output=output/%x-%a-%A.out
#SBATCH --mail-user=alc307@pitt.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=3-00:00:00
#SBATCH --partition=a100
#SBATCH --qos=short
#SBATCH --constraint=amd,ntasks-per-node=1
#SBATCH --array=0-2

echo "RUN:" `date`
module load gcc/8.2.0 python/anaconda3.10-2022.10
source activate cs3730
unset PYTHONHOME
unset PYTHONPATH
version=`python finetune_repeat.py --version`
echo "RUNNING $version SCRIPT"
python finetune_repeat.py -m google/mt5-small \
						  -dmt datasets/ix_datasets/opus \
						  -s train \
						  -lc 1 \
						  -sl en \
						  -tl es \
						  -op 1 \
						  -drt datasets/ix_datasets/opus_flan_opus_nllb \
						  -mts flan-t5-large nllb-200-distilled-600M \
						  -mtk flan-t5-large_score nllb-200-distilled-600M_score \
						  -ts 0.3 \
						  -tb 256 \
						  -t "English to Spanish" \
						  -me sacrebleu \
						  -mk score \
						  -sk 1 \
						  -f 1 \
						  -l 4e-5 \
						  -e 2 \
						  -b 16 \
						  -tm $SLURM_ARRAY_TASK_ID \
						  -sa 1 \
						  -x 100 \
						  -o models/ix_models/repeat-$SLURM_ARRAY_TASK_ID \
						  -lo logs
echo "DONE"
command -v crc-job-stats &> /dev/null && command crc-job-stats
