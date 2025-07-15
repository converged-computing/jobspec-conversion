#!/bin/bash
#FLUX: --job-name=PatchExtractor
#FLUX: -c=10
#FLUX: --queue=gpuhm
#FLUX: -t=360000
#FLUX: --urgency=16

module use /opt/software/easybuild/modules/all/
module load Mamba
source ~/.bashrc
mamba activate  dl_torch
cd /home/ofourkioti/Projects/GT-2022-histo/
for i in {0..4};
do CUDA_VISIBLE_DEVICES=0 python main.py --n_class 3 --data_path "/data/scratch/DBI/DUDBI/DYNCESYS/OlgaF/tmi/rcc/" --train_set "/home/ofourkioti/Projects/HistoTree/rcc_files/train_${i}.txt" --val_set "/home/ofourkioti/Projects/HistoTree/rcc_files/val_${i}.txt" --model_path "graph_transformer/saved_models/" --log_path "graph_transformer/runs/" --task_name "gtp_rcc_${i}" --batch_size 4 --train --log_interval_local 5
done
