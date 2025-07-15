#!/bin/bash
#FLUX: --job-name=conspicuous-cattywampus-3479
#FLUX: -c=2
#FLUX: --queue=gpu
#FLUX: -t=21600
#FLUX: --priority=16

module load python/anaconda3-2018.12
source activate pytorch-2023
python /work/TALC/enel645_2023w/Garbage-classification/garbage_main.py --best_model_path /work/TALC/enel645_2023w/Garbage-classification/garbage_net.pth --images_path /work/TALC/enel645_2023w/Garbage-classification/ --transfer_learning True
conda deactivate
