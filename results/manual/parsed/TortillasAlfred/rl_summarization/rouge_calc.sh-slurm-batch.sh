#!/bin/bash
#SBATCH --account=def-corbeilj
#SBATCH --output=/scratch/magod/rouge_calc/%A_%a.out
#SBATCH --mail-user=mathieu.godbout.3@ulaval.ca
#SBATCH --mail-type=FAIL,TIME_LIMIT
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=25G
#SBATCH --time=00:06:00
#SBATCH --array=0-20

mkdir /scratch/magod/rouge_calc/
source ~/venvs/default/bin/activate
date
SECONDS=0
python -um src.scripts.rouge $SLURM_ARRAY_TASK_ID --data_path=/scratch/magod/summarization_datasets/cnn_dailymail/data --vectors_cache=/scratch/magod/embeddings/ --target_dir=/scratch/magod/summarization_datasets/cnn_dailymail/data/rouge_npy/ --dataset=val
diff=$SECONDS
echo "$(($diff / 60)) minutes and $(($diff % 60)) seconds elapsed."
date
