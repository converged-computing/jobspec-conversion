#!/bin/bash
#FLUX: --job-name=wobbly-destiny-0997
#FLUX: --urgency=16

CUDA_VISIBLE_DEVICES=0 python edit_cli.py --resolution 256 --ckpt logs/train_all100kdata_add_coco_pet_seg_blue/checkpoints/epoch=000020.ckpt --input data/oxford-pets --output ./outputs/imgs_test_pets_seg/ --edit "segment the %" --task pet_seg
