#!/bin/bash
#FLUX: --job-name=adorable-hope-3248
#FLUX: --urgency=16

python code/models_prototype_pruning.py --dataset STANFORDCARS --base_architecture densenet121 --batchsize 16 --optimize_last_layer --num_workers 3 --gpu_id 0 --checkpoint
python code/models_prototype_pruning.py --dataset STANFORDCARS --base_architecture densenet161 --batchsize 16 --optimize_last_layer --num_workers 3 --gpu_id 0 --checkpoint
python code/models_prototype_pruning.py --dataset STANFORDCARS --base_architecture resnet34 --batchsize 16 --optimize_last_layer --num_workers 3 --gpu_id 0 --checkpoint
python code/models_prototype_pruning.py --dataset STANFORDCARS --base_architecture resnet152 --batchsize 16 --optimize_last_layer --num_workers 3 --gpu_id 0 --checkpoint
python code/models_prototype_pruning.py --dataset STANFORDCARS --base_architecture vgg16 --batchsize 16 --optimize_last_layer --num_workers 3 --gpu_id 0 --checkpoint
python code/models_prototype_pruning.py --dataset STANFORDCARS --base_architecture vgg19 --batchsize 16 --optimize_last_layer --num_workers 3 --gpu_id 0 --checkpoint
echo "Finished."
