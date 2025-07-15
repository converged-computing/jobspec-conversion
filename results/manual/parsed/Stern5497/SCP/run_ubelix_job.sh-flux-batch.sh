#!/bin/bash
#FLUX: --job-name=LEXTREME
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

module load Workspace Anaconda3/2021.11-foss-2021a CUDA/11.3.0-GCC-10.2.0
eval "$(conda shell.bash hook)"
conda activate scp-test
python main.py --task swiss_bge_criticality_prediction -gm 24 -bz 8 -los 1 --num_train_epochs 10 -ld results/test_scp --language_model_type microsoft/mdeberta-v3-base --hierarchical True --running_mode experimental
