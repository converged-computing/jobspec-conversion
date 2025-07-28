#!/bin/bash
#FLUX: --job-name=hello-house-7005
#FLUX: -n=4
#FLUX: --queue=part1
#FLUX: --urgency=16

CUDA_VISIBLE_DEVICES=1 python evaluate.py --save_path result_imgs_pas100
