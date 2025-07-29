#!/bin/bash
#SBATCH --job-name=DeepRAM-snakemake
#SBATCH --output=logs/%j.job
#SBATCH --error=logs/%j.job
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=15G
#SBATCH --time=1-00:00:00
#SBATCH --partition=gpu_p
#SBATCH --qos=low
#SBATCH --exclude=supergpu02pxe,supergpu03pxe,supergpu05,supergpu07,supergpu08

sbatch --wait << EOF
echo HOSTNAME=$HOSTNAME
source $HOME/.bashrc
conda activate deepram
python deepRAM/deepRAM.py --data_type DNA --train True --train_data $1 --test_data $2 --model_path $3 --word2vec_model $4 --Embedding True --Conv True --conv_layers 1 --RNN True --RNN_type BiLSTM
EOF
