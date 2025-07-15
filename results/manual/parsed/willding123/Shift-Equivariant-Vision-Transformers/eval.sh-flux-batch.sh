#!/bin/bash
#FLUX: --job-name=eval1
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=7200
#FLUX: --urgency=16

module load cuda/11.6.2/
source ~/scratch.cmsc663/miniconda3/bin/activate
conda activate swin 
cd ~/scratch.cmsc663/Swin-Transformer 
python eval.py --model polyvit --model_card timm/vit_base_patch16_224.augreg_in1k --data_path ~/scratch.cmsc663/val --batch_size 64 --pretrained_path ~/scratch.cmsc663/pvit_b_1kscratch --write_csv --ckpt_num 185
python eval.py --model polyvit --model_card timm/vit_base_patch16_224.augreg_in1k --data_path ~/scratch.cmsc663/val --batch_size 64 --pretrained_path ~/scratch.cmsc663/pvit_b_1kscratch --write_csv --shift_attack --ckpt_num 185
python eval.py --model polyvit --model_card timm/vit_base_patch16_224.augreg_in1k --data_path ~/scratch.cmsc663/val --batch_size 64 --pretrained_path ~/scratch.cmsc663/pvit_b_1kscratch --write_csv --random_affine --ckpt_num 185
python eval.py --model polyvit --model_card timm/vit_base_patch16_224.augreg_in1k --data_path ~/scratch.cmsc663/val --batch_size 64 --pretrained_path ~/scratch.cmsc663/pvit_b_1kscratch --write_csv --random_perspective --ckpt_num 185
python eval.py --model polyvit --model_card timm/vit_base_patch16_224.augreg_in1k --data_path ~/scratch.cmsc663/val --batch_size 64 --pretrained_path ~/scratch.cmsc663/pvit_b_1kscratch --write_csv --crop --ckpt_num 185
python eval.py --model polyvit --model_card timm/vit_base_patch16_224.augreg_in1k --data_path ~/scratch.cmsc663/val --batch_size 64 --pretrained_path ~/scratch.cmsc663/pvit_b_1kscratch --write_csv --flip --ckpt_num 185
python eval.py --model polyvit --model_card timm/vit_base_patch16_224.augreg_in1k --data_path ~/scratch.cmsc663/val --batch_size 64 --pretrained_path ~/scratch.cmsc663/pvit_b_1kscratch --write_csv --random_erasing --ckpt_num 185
python eval.py --model polyvit --model_card timm/vit_base_patch16_224.augreg_in1k --data_path ~/scratch.cmsc663/val --batch_size 64 --pretrained_path ~/scratch.cmsc663/pvit_b_1kscratch --write_csv --all_attack --ckpt_num 185
python eval.py --model polyvit --model_card timm/vit_small_patch16_224.augreg_in1k --data_path ~/scratch.cmsc663/val --batch_size 64 --pretrained_path ~/scratch.cmsc663/pvit_s_1kscratch --write_csv
python eval.py --model polyvit --model_card timm/vit_small_patch16_224.augreg_in1k --data_path ~/scratch.cmsc663/val --batch_size 64 --pretrained_path ~/scratch.cmsc663/pvit_s_1kscratch --write_csv --shift_attack
python eval.py --model polyvit --model_card timm/vit_small_patch16_224.augreg_in1k --data_path ~/scratch.cmsc663/val --batch_size 64  --pretrained_path ~/scratch.cmsc663/pvit_s_1kscratch --write_csv --random_affine
python eval.py --model polyvit --model_card timm/vit_small_patch16_224.augreg_in1k --data_path ~/scratch.cmsc663/val --batch_size 64 --pretrained_path ~/scratch.cmsc663/pvit_s_1kscratch --write_csv --random_perspective
python eval.py --model polyvit --model_card timm/vit_small_patch16_224.augreg_in1k --data_path ~/scratch.cmsc663/val --batch_size 64 --pretrained_path ~/scratch.cmsc663/pvit_s_1kscratch --write_csv --crop 
python eval.py --model polyvit --model_card timm/vit_small_patch16_224.augreg_in1k --data_path ~/scratch.cmsc663/val --batch_size 64 --pretrained_path ~/scratch.cmsc663/pvit_s_1kscratch --write_csv --flip 
python eval.py --model polyvit --model_card timm/vit_small_patch16_224.augreg_in1k --data_path ~/scratch.cmsc663/val --batch_size 64 --pretrained_path ~/scratch.cmsc663/pvit_s_1kscratch --write_csv --random_erasing
python eval.py --model polyvit --model_card timm/vit_small_patch16_224.augreg_in1k --data_path ~/scratch.cmsc663/val --batch_size 64 --pretrained_path ~/scratch.cmsc663/pvit_s_1kscratch --write_csv --all_attack
python eval.py --model vit --model_card timm/vit_small_patch16_224.augreg_in1k --data_path ~/scratch.cmsc663/val --batch_size 64 --pretrained_path ~/scratch.cmsc663/vit_s_1kscratch --write_csv
python eval.py --model vit --model_card timm/vit_small_patch16_224.augreg_in1k --data_path ~/scratch.cmsc663/val --batch_size 64 --pretrained_path  ~/scratch.cmsc663/vit_s_1kscratch --write_csv --shift_attack
python eval.py --model vit --model_card timm/vit_small_patch16_224.augreg_in1k --data_path ~/scratch.cmsc663/val --batch_size 64 --pretrained_path  ~/scratch.cmsc663/vit_s_1kscratch --write_csv --random_affine
python eval.py --model vit --model_card timm/vit_small_patch16_224.augreg_in1k --data_path ~/scratch.cmsc663/val --batch_size 64 --pretrained_path  ~/scratch.cmsc663/vit_s_1kscratch --write_csv --random_perspective
python eval.py --model vit --model_card timm/vit_small_patch16_224.augreg_in1k --data_path ~/scratch.cmsc663/val --batch_size 64 --pretrained_path  ~/scratch.cmsc663/vit_s_1kscratch --write_csv --crop
python eval.py --model vit --model_card timm/vit_small_patch16_224.augreg_in1k --data_path ~/scratch.cmsc663/val --batch_size 64 --pretrained_path  ~/scratch.cmsc663/vit_s_1kscratch --write_csv --flip
python eval.py --model vit --model_card timm/vit_small_patch16_224.augreg_in1k --data_path ~/scratch.cmsc663/val --batch_size 64 --pretrained_path  ~/scratch.cmsc663/vit_s_1kscratch --write_csv --random_erasing
python eval.py --model vit --model_card timm/vit_small_patch16_224.augreg_in1k --data_path ~/scratch.cmsc663/val --batch_size 64 --pretrained_path  ~/scratch.cmsc663/vit_s_1kscratch --write_csv --all_attack
