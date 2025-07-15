#!/bin/bash
#FLUX: --job-name=e5_7_gpt2_vnla__e5_8_gpt2_vnla__e5_9_gpt2_vnla__e5_10_gpt2_vnla__e5_11_gpt2_vnla__e5_12_gpt2_vnla
#FLUX: --queue=m3g
#FLUX: -t=604800
#FLUX: --priority=16

module load anaconda/5.0.1-Python3.6-gcc5
source activate /home/twu/da33/tong/envs/pseudoCL/
module load cuda/11.0
python3 -m utils.main --info e5_7_gpt2_vnla --seed 0 --model vanilla_nlp --area NLP --dataset seq-clinc150 --csv_log --tensorboard --lr 5e-05 --ptm gpt2 --eval_freq 1 --prob_l 7 --filter_rate 1  --batch_size 16 --n_epochs 50
python3 -m utils.main --info e5_8_gpt2_vnla --seed 0 --model vanilla_nlp --area NLP --dataset seq-clinc150 --csv_log --tensorboard --lr 5e-05 --ptm gpt2 --eval_freq 1 --prob_l 8 --filter_rate 1  --batch_size 16 --n_epochs 50
python3 -m utils.main --info e5_9_gpt2_vnla --seed 0 --model vanilla_nlp --area NLP --dataset seq-clinc150 --csv_log --tensorboard --lr 5e-05 --ptm gpt2 --eval_freq 1 --prob_l 9 --filter_rate 1  --batch_size 16 --n_epochs 50
python3 -m utils.main --info e5_10_gpt2_vnla --seed 0 --model vanilla_nlp --area NLP --dataset seq-clinc150 --csv_log --tensorboard --lr 5e-05 --ptm gpt2 --eval_freq 1 --prob_l 10 --filter_rate 1  --batch_size 16 --n_epochs 50
python3 -m utils.main --info e5_11_gpt2_vnla --seed 0 --model vanilla_nlp --area NLP --dataset seq-clinc150 --csv_log --tensorboard --lr 5e-05 --ptm gpt2 --eval_freq 1 --prob_l 11 --filter_rate 1  --batch_size 16 --n_epochs 50
python3 -m utils.main --info e5_12_gpt2_vnla --seed 0 --model vanilla_nlp --area NLP --dataset seq-clinc150 --csv_log --tensorboard --lr 5e-05 --ptm gpt2 --eval_freq 1 --prob_l 12 --filter_rate 1  --batch_size 16 --n_epochs 50
