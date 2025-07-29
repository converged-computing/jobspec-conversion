#!/bin/bash
#FLUX: --job-name=train_thermal
#FLUX: -c=8
#FLUX: -t=86400
#FLUX: --urgency=16

eval "$(conda shell.bash hook)"
conda activate VTL
python3 train.py --dataset_name=satellite_0_thermalmapping_135 --mining=partial --datasets_folder=datasets --infer_batch_size 16 --train_batch_size 4 --lr 0.0001 --patience 100 --epochs_num 100 --use_faiss_gpu --conv_output_dim 4096 --add_bn --backbone resnet50conv4
