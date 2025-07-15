#!/bin/bash
#FLUX: --job-name=ornery-caramel-1094
#FLUX: --urgency=16

CUDA_VISIBLE_DEVICES=1 python evaluate.py --save_path result_imgs_pas100
