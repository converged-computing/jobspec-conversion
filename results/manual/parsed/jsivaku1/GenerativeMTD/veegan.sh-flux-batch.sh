#!/bin/bash
#FLUX: --job-name=VEEGAN
#FLUX: --queue=gpucompute
#FLUX: --priority=16

module load cuda11.1/toolkit/11.1.1
conda activate deepmtd
python3 train.py --model 'veegan' --dataset 'Data/imputed_SweatBinary.csv' --target_col_ix 18 --k 3 --num_obs 100 --epochs 200
python3 train.py --model 'veegan' --dataset 'Data/cleveland_heart.csv' --target_col_ix 13 --k 5 --num_obs 10 --epochs 200
python3 train.py --model 'veegan' --dataset 'Data/urban_land.csv' --target_col_ix 0 --k 10 --num_obs 10 --epochs 200
python3 train.py --model 'veegan' --dataset 'Data/mammography.csv' --target_col_ix 5 --k 5 --num_obs 100 --epochs 200
python3 train.py --model 'veegan' --dataset 'Data/immunotherapy.csv' --target_col_ix 7 --k 8 --num_obs 100 --epochs 200
python3 train.py --model 'veegan' --dataset 'Data/cryotherapy.csv' --target_col_ix 6 --k 6 --num_obs 100 --epochs 200
python3 train.py --model 'veegan' --dataset 'Data/caesarian.csv' --target_col_ix 5 --k 6 --num_obs 100 --epochs 200
python3 train.py --model 'veegan' --dataset 'Data/cervical.csv' --target_col_ix 19 --k 3 --num_obs 100 --epochs 200
python3 train.py --model 'veegan' --dataset 'Data/breast.csv' --target_col_ix 9 --k 3 --num_obs 100 --epochs 200
python3 train.py --model 'veegan' --dataset 'Data/post_operative.csv' --target_col_ix 8 --k 6 --num_obs 100 --epochs 200
python3 train.py --model 'veegan' --dataset 'Data/community_crime.csv' --target_col_ix 122 --ml_utility regression --k 5 --num_obs 10 --epochs 200
python3 train.py --model 'veegan' --dataset 'Data/sweat_ordinal.csv' --target_col_ix 18 --ml_utility regression --k 3 --num_obs 100 --epochs 200
python3 train.py --model 'veegan' --dataset 'Data/fertility.csv' --target_col_ix 8 --ml_utility regression --k 4 --num_obs 100 --epochs 200
python3 train.py --model 'veegan' --dataset 'Data/parkinsons.csv' --target_col_ix 22 --ml_utility regression --k 3 --num_obs 100 --epochs 200
python3 train.py --model 'veegan' --dataset 'Data/thyroid.csv' --target_col_ix 5 --ml_utility regression --k 6 --num_obs 100 --epochs 200
python3 train.py --model 'veegan' --dataset 'Data/liver.csv' --target_col_ix 1 --ml_utility regression --k 4 --num_obs 100 --epochs 200
python3 train.py --model 'veegan' --dataset 'Data/fat.csv' --target_col_ix 0 --ml_utility regression --k 7 --num_obs 100 --epochs 200
python3 train.py --model 'veegan' --dataset 'Data/pima.csv' --target_col_ix 6 --ml_utility regression --k 3 --num_obs 100 --epochs 200
python3 train.py --model 'veegan' --dataset 'Data/prostate.csv' --target_col_ix 8 --ml_utility regression --k 4 --num_obs 100 --epochs 200
python3 train.py --model 'veegan' --dataset 'Data/bioconcentration.csv' --target_col_ix 10 --ml_utility regression --k 3 --num_obs 100 --epochs 200
python3 train.py --model 'veegan' --dataset 'Data/heartfail.csv' --target_col_ix 12 --ml_utility regression --k 3 --num_obs 100 --epochs 200
