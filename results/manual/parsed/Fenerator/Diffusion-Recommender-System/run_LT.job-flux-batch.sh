#!/bin/bash
#FLUX: --job-name=LT
#FLUX: -c=3
#FLUX: --queue=gpu_titanrtx_shared_course
#FLUX: -t=86400
#FLUX: --priority=16

module purge
module load 2021
module load Anaconda3/2021.05
source activate rs
NAME='Reproduction'
SEED=1
python ./LT-DiffRec/main.py --data_path ./datasets/ --dataset=yelp_clean --cuda --gpu=1 --run_name=$NAME --seed $SEED --n_cate 2
python ./LT-DiffRec/main.py --data_path ./datasets/ --dataset=yelp_noisy --cuda --gpu=1 --run_name=$NAME --seed $SEED --n_cate 2
python ./LT-DiffRec/main.py --data_path ./datasets/ --dataset=ml-1m_clean --cuda --gpu=1 --run_name=$NAME --seed $SEED --n_cate 2
python ./LT-DiffRec/main.py --data_path ./datasets/ --dataset=ml-1m_noisy --cuda --gpu=1 --run_name=$NAME --seed $SEED --n_cate 2
python ./LT-DiffRec/main.py --data_path ./datasets/ --dataset=amazon-book_clean --cuda --gpu=1 --num_workers 0 --run_name=$NAME --seed $SEED --n_cate 2
python ./LT-DiffRec/main.py --data_path ./datasets/ --dataset=amazon-book_noisy --cuda --gpu=1 --num_workers 0 --run_name=$NAME --seed $SEED --n_cate 2
SEED=2
python ./LT-DiffRec/main.py --data_path ./datasets/ --dataset=yelp_clean --cuda --gpu=1 --run_name=$NAME --seed $SEED --n_cate 2
python ./LT-DiffRec/main.py --data_path ./datasets/ --dataset=yelp_noisy --cuda --gpu=1 --run_name=$NAME --seed $SEED --n_cate 2
python ./LT-DiffRec/main.py --data_path ./datasets/ --dataset=ml-1m_clean --cuda --gpu=1 --run_name=$NAME --seed $SEED --n_cate 2
python ./LT-DiffRec/main.py --data_path ./datasets/ --dataset=ml-1m_noisy --cuda --gpu=1 --run_name=$NAME --seed $SEED --n_cate 2
python ./LT-DiffRec/main.py --data_path ./datasets/ --dataset=amazon-book_clean --cuda --gpu=1 --num_workers 0 --run_name=$NAME --seed $SEED --n_cate 2
python ./LT-DiffRec/main.py --data_path ./datasets/ --dataset=amazon-book_noisy --cuda --gpu=1 --num_workers 0 --run_name=$NAME --seed $SEED --n_cate 2
SEED=3
python ./LT-DiffRec/main.py --data_path ./datasets/ --dataset=yelp_clean --cuda --gpu=1 --run_name=$NAME --seed $SEED --n_cate 2
python ./LT-DiffRec/main.py --data_path ./datasets/ --dataset=yelp_noisy --cuda --gpu=1 --run_name=$NAME --seed $SEED --n_cate 2
python ./LT-DiffRec/main.py --data_path ./datasets/ --dataset=ml-1m_clean --cuda --gpu=1 --run_name=$NAME --seed $SEED --n_cate 2
python ./LT-DiffRec/main.py --data_path ./datasets/ --dataset=ml-1m_noisy --cuda --gpu=1 --run_name=$NAME --seed $SEED --n_cate 2
python ./LT-DiffRec/main.py --data_path ./datasets/ --dataset=amazon-book_clean --cuda --gpu=1 --num_workers 0 --run_name=$NAME --seed $SEED --n_cate 2
python ./LT-DiffRec/main.py --data_path ./datasets/ --dataset=amazon-book_noisy --cuda --gpu=1 --num_workers 0 --run_name=$NAME --seed $SEED --n_cate 2
SEED=4
python ./LT-DiffRec/main.py --data_path ./datasets/ --dataset=yelp_clean --cuda --gpu=1 --run_name=$NAME --seed $SEED --n_cate 2
python ./LT-DiffRec/main.py --data_path ./datasets/ --dataset=yelp_noisy --cuda --gpu=1 --run_name=$NAME --seed $SEED --n_cate 2
python ./LT-DiffRec/main.py --data_path ./datasets/ --dataset=ml-1m_clean --cuda --gpu=1 --run_name=$NAME --seed $SEED --n_cate 2
python ./LT-DiffRec/main.py --data_path ./datasets/ --dataset=ml-1m_noisy --cuda --gpu=1 --run_name=$NAME --seed $SEED --n_cate 2
python ./LT-DiffRec/main.py --data_path ./datasets/ --dataset=amazon-book_clean --cuda --gpu=1 --num_workers 0 --run_name=$NAME --seed $SEED --n_cate 2
python ./LT-DiffRec/main.py --data_path ./datasets/ --dataset=amazon-book_noisy --cuda --gpu=1 --num_workers 0 --run_name=$NAME --seed $SEED --n_cate 2
SEED=5
python ./LT-DiffRec/main.py --data_path ./datasets/ --dataset=yelp_clean --cuda --gpu=1 --run_name=$NAME --seed $SEED --n_cate 2
python ./LT-DiffRec/main.py --data_path ./datasets/ --dataset=yelp_noisy --cuda --gpu=1 --run_name=$NAME --seed $SEED --n_cate 2
python ./LT-DiffRec/main.py --data_path ./datasets/ --dataset=ml-1m_clean --cuda --gpu=1 --run_name=$NAME --seed $SEED --n_cate 2
python ./LT-DiffRec/main.py --data_path ./datasets/ --dataset=ml-1m_noisy --cuda --gpu=1 --run_name=$NAME --seed $SEED --n_cate 2
python ./LT-DiffRec/main.py --data_path ./datasets/ --dataset=amazon-book_clean --cuda --gpu=1 --num_workers 0 --run_name=$NAME --seed $SEED --n_cate 2
python ./LT-DiffRec/main.py --data_path ./datasets/ --dataset=amazon-book_noisy --cuda --gpu=1 --num_workers 0 --run_name=$NAME --seed $SEED --n_cate 2
conda deactivate
