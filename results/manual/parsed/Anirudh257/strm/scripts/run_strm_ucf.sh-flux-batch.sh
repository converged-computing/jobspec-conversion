#!/bin/bash
#FLUX: --job-name=strm
#FLUX: -c=24
#FLUX: -t=172800
#FLUX: --priority=16

NEW_HOME="./strm_ucf_tempset_2/"
COMMAND_TO_RUN="python3 run.py -c checkpoint_dir_ucf/ --query_per_class 4 --shot 5 --way 5 --trans_linear_out_dim 1152 --test_iters 10000 --dataset ucf --split 3 -lr 0.0001 --img_size 224 --scratch new --num_gpus 4 --method resnet50 --save_freq 10000 --print_freq 1 --training_iterations 20010 --temp_set 2"
echo ""
echo "Date = $(date)"
echo "Hostname = $(hostname -s)"
echo "Working Directory = $NEW_HOME"
echo "Command = $COMMAND_TO_RUN"
echo ""
cd $NEW_HOME
srun $COMMAND_TO_RUN
