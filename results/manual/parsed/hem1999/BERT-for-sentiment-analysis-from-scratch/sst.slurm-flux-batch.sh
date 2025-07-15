#!/bin/bash
#FLUX: --job-name=gpu_basics
#FLUX: --queue=gpuq
#FLUX: -t=7200
#FLUX: --urgency=16

set echo 
umask 0022 
nvidia-smi
module load gnu10
source /home/vduddu/miniconda/bin/activate bert_hw
python /home/vduddu/678_hw1/classifier.py --option finetune --epochs 20 --lr 5e-5 --train /home/vduddu/678_hw1/data/sst-train.txt --dev /home/vduddu/678_hw1/data/sst-dev.txt --test /home/vduddu/678_hw1/data/sst-test.txt --dev_out sst-dev-output.finetune.txt --test_out sst-test-output.finetune.txt --batch_size 8 --hidden_dropout_prob 0.3 --use_gpu
python /home/vduddu/678_hw1/classifier.py --option pretrain --epochs 20 --lr 5e-5 --train /home/vduddu/678_hw1/data/sst-train.txt --dev /home/vduddu/678_hw1/data/sst-dev.txt --test /home/vduddu/678_hw1/data/sst-test.txt --dev_out sst-dev-output.pretrain.txt --test_out sst-test-output.pretrain.txt --batch_size 8 --hidden_dropout_prob 0.3 --use_gpu
