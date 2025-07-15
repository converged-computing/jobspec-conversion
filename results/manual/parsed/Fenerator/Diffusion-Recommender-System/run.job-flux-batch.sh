#!/bin/bash
#FLUX: --job-name=TEST
#FLUX: -c=3
#FLUX: --queue=gpu_titanrtx_shared_course
#FLUX: -t=14400
#FLUX: --urgency=16

module purge
module load 2021
module load Anaconda3/2021.05
source activate rs
python ./T-DiffRec/inference.py --data_path ./datasets/ --dataset=yelp_clean --cuda --gpu=1 # DONE # Cant be run on yelp noisy!
python ./L-DiffRec/inference.py --data_path ./datasets/ --dataset=yelp_noisy --cuda --gpu=1 --sampling_steps 0 --steps 100 # DONE, but paras modified; Cant be run on yelp noisy!
python ./LT-DiffRec/inference.py --data_path ./datasets/ --dataset=yelp_clean --cuda --gpu=1 --sampling_steps 0 --steps 100 # DONE, but paras modified
conda deactivate
