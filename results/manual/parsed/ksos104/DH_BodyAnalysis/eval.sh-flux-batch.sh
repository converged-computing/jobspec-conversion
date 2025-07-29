#!/bin/bash
#FLUX --job-name=gloopy-motorcycle-3874
#FLUX -n=4
#FLUX --queue=part1
#FLUX --urgency=16

CUDA_VISIBLE_DEVICES=1 python evaluate.py --save_path result_imgs_pas100
