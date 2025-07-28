#!/bin/bash
#FLUX: --job-name=T-seed
#FLUX: -c=3
#FLUX: --queue=gpu_titanrtx_shared_course
#FLUX: -t=172800
#FLUX: --urgency=16

module purge
module load 2021
module load Anaconda3/2021.05
source activate rs
NAME='Reproduction'
SEED=1
python ./T-DiffRec/main.py --data_path ./datasets/ --dataset=yelp_clean --cuda --gpu=0 --run_name=$NAME --seed $SEED
python ./T-DiffRec/main.py --data_path ./datasets/ --dataset=yelp_noisy --cuda --gpu=0 --run_name=$NAME --seed $SEED
python ./T-DiffRec/main.py --data_path ./datasets/ --dataset=ml-1m_clean --cuda --gpu=0 --run_name=$NAME --seed $SEED
python ./T-DiffRec/main.py --data_path ./datasets/ --dataset=ml-1m_noisy --cuda --gpu=0 --run_name=$NAME --seed $SEED
SEED=2
python ./T-DiffRec/main.py --data_path ./datasets/ --dataset=yelp_clean --cuda --gpu=0 --run_name=$NAME --seed $SEED
python ./T-DiffRec/main.py --data_path ./datasets/ --dataset=yelp_noisy --cuda --gpu=0 --run_name=$NAME --seed $SEED
python ./T-DiffRec/main.py --data_path ./datasets/ --dataset=ml-1m_clean --cuda --gpu=0 --run_name=$NAME --seed $SEED
python ./T-DiffRec/main.py --data_path ./datasets/ --dataset=ml-1m_noisy --cuda --gpu=0 --run_name=$NAME --seed $SEED
SEED=3
python ./T-DiffRec/main.py --data_path ./datasets/ --dataset=yelp_clean --cuda --gpu=0 --run_name=$NAME --seed $SEED
python ./T-DiffRec/main.py --data_path ./datasets/ --dataset=yelp_noisy --cuda --gpu=0 --run_name=$NAME --seed $SEED
python ./T-DiffRec/main.py --data_path ./datasets/ --dataset=ml-1m_clean --cuda --gpu=0 --run_name=$NAME --seed $SEED
python ./T-DiffRec/main.py --data_path ./datasets/ --dataset=ml-1m_noisy --cuda --gpu=0 --run_name=$NAME --seed $SEED
SEED=4
python ./T-DiffRec/main.py --data_path ./datasets/ --dataset=yelp_clean --cuda --gpu=0 --run_name=$NAME --seed $SEED
python ./T-DiffRec/main.py --data_path ./datasets/ --dataset=yelp_noisy --cuda --gpu=0 --run_name=$NAME --seed $SEED
python ./T-DiffRec/main.py --data_path ./datasets/ --dataset=ml-1m_clean --cuda --gpu=0 --run_name=$NAME --seed $SEED
python ./T-DiffRec/main.py --data_path ./datasets/ --dataset=ml-1m_noisy --cuda --gpu=0 --run_name=$NAME --seed $SEED
SEED=5
python ./T-DiffRec/main.py --data_path ./datasets/ --dataset=yelp_clean --cuda --gpu=0 --run_name=$NAME --seed $SEED
python ./T-DiffRec/main.py --data_path ./datasets/ --dataset=yelp_noisy --cuda --gpu=0 --run_name=$NAME --seed $SEED
python ./T-DiffRec/main.py --data_path ./datasets/ --dataset=ml-1m_clean --cuda --gpu=0 --run_name=$NAME --seed $SEED
python ./T-DiffRec/main.py --data_path ./datasets/ --dataset=ml-1m_noisy --cuda --gpu=0 --run_name=$NAME --seed $SEED
SEED=1
python ./T-DiffRec/main.py --data_path ./datasets/ --dataset=amazon-book_clean --cuda --gpu=0  --num_workers 0 --seed $SEED --run_name=$NAME
python ./T-DiffRec/main.py --data_path ./datasets/ --dataset=amazon-book_noisy --cuda --gpu=0  --num_workers 0 --seed $SEED --run_name=$NAME
SEED=2
python ./T-DiffRec/main.py --data_path ./datasets/ --dataset=amazon-book_clean --cuda --gpu=0  --num_workers 0 --seed $SEED --run_name=$NAME
python ./T-DiffRec/main.py --data_path ./datasets/ --dataset=amazon-book_noisy --cuda --gpu=0  --num_workers 0 --seed $SEED --run_name=$NAME
SEED=3
python ./T-DiffRec/main.py --data_path ./datasets/ --dataset=amazon-book_clean --cuda --gpu=0  --num_workers 0 --seed $SEED --run_name=$NAME
python ./T-DiffRec/main.py --data_path ./datasets/ --dataset=amazon-book_noisy --cuda --gpu=0  --num_workers 0 --seed $SEED --run_name=$NAME
SEED=4
python ./T-DiffRec/main.py --data_path ./datasets/ --dataset=amazon-book_clean --cuda --gpu=0  --num_workers 0 --seed $SEED --run_name=$NAME
python ./T-DiffRec/main.py --data_path ./datasets/ --dataset=amazon-book_noisy --cuda --gpu=0  --num_workers 0 --seed $SEED --run_name=$NAME
SEED=5
python ./T-DiffRec/main.py --data_path ./datasets/ --dataset=amazon-book_clean --cuda --gpu=0  --num_workers 0 --seed $SEED --run_name=$NAME
python ./T-DiffRec/main.py --data_path ./datasets/ --dataset=amazon-book_noisy --cuda --gpu=0  --num_workers 0 --seed $SEED --run_name=$NAME
conda deactivate
