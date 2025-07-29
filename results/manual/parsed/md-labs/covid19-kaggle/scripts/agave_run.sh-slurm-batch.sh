#!/bin/bash
#SBATCH --job-name=BERT_Agave
#SBATCH --output=MTDNN_Agave.OUT
#SBATCH --error=MTDNN_Agave.ERROR
#SBATCH --mail-user=mihirparmar@asu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=24
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --time=01:00:00

export OMP_NUM_THREADS='24'

export OMP_NUM_THREADS=24
module load anaconda3/5.3.0
python3 bert_covid.py --data_dir=./data --bert_model=bert-base-uncased --output_dir=./output_128 --max_seq_length=128 --num_train_epochs=10 --do_eval --train_batch_size=8 --eval_batch_size=1
