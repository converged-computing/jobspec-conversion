#!/bin/bash
#FLUX: --job-name=adorable-cinnamonbun-7689
#FLUX: --priority=16

CUDA_VISIBLE_DEVICES=1 python evaluate.py --save_path result_imgs_pas100
