#!/bin/bash
#FLUX: --job-name=gpt2_convai
#FLUX: -c=16
#FLUX: -t=86400
#FLUX: --priority=16

cd /h/haotian/Code/csc2621-ChatbotAD/transfer-learning-conv-ai
source /pkgs/anaconda3/bin/activate csc2621
which python
(while true; do nvidia-smi; top -b -n 1 | head -20; sleep 10; done) &
python -m torch.distributed.launch --nproc_per_node=8 ./train.py --gradient_accumulation_steps=4 --lm_coef=2.0 --max_history=2 --n_epochs=1 --num_candidates=4 --personality_permutations=2 --train_batch_size=2 --valid_batch_size=2
