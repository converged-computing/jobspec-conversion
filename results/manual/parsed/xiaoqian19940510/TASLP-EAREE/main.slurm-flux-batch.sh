#!/bin/bash
#FLUX: --job-name=TDG_SNEE
#FLUX: -c=10
#FLUX: --queue=sugon
#FLUX: --urgency=16

CUDA_VISIBLE_DEVICES=0,1 python TC_preprocess.py
CUDA_VISIBLE_DEVICES=0,1 python TC/run_bert.py --do_data 
CUDA_VISIBLE_DEVICES=0,1 python TC/run_bert.py --do_train --save_best
CUDA_VISIBLE_DEVICES=0,1 python TC/run_bert.py --do_test
CUDA_VISIBLE_DEVICES=0,1 python AI_RC_preprocess.py
CUDA_VISIBLE_DEVICES=0,1 python AI_RC/get_data.py
CUDA_VISIBLE_DEVICES=0 python AI_RC/train_start.py
CUDA_VISIBLE_DEVICES=0 python AI_RC/test.py
