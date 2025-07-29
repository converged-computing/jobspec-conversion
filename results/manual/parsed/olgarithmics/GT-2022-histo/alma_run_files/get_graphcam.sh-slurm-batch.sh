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
do export CUDA_VISIBLE_DEVICES=0
python main.py \
--n_class 2 \
--data_path '/data/scratch/DBI/DUDBI/DYNCESYS/OlgaF/tmi/tcga_lung/' \
--val_set "colon_splits/test_${i}.txt" \
--model_path "graph_transformer/saved_models/" \
--log_path "graph_transformer/runs/" \
--task_name "tcga_lung_${i}"  \
--batch_size 1 \
--test \
--log_interval_local 5 \
--resume "graph_transformer/saved_models/tcga_lung_${i}.pth" \
--graphcam
done
