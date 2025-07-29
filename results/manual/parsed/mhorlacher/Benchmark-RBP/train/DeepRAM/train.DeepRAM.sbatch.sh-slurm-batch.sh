#!/bin/bash
#FLUX: --job-name=DeepRAM-snakemake
#FLUX: -c=4
#FLUX: --queue=gpu_p
#FLUX: -t=86400
#FLUX: --urgency=15

sbatch --wait << EOF
echo HOSTNAME=$HOSTNAME
source $HOME/.bashrc
conda activate deepram
python deepRAM/deepRAM.py --data_type DNA --train True --train_data $1 --test_data $2 --model_path $3 --word2vec_model $4 --Embedding True --Conv True --conv_layers 1 --RNN True --RNN_type BiLSTM
EOF
