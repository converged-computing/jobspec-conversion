#!/bin/bash
#FLUX: --job-name=pap_r34
#FLUX: --queue=gtx1080ti_11GB
#FLUX: --urgency=16

echo "PAPILA | Started | Training"
model="baseline"
if [ $model == "baseline" ]
then
    echo "Baseline | ResNet34"
    python code/baseline/models_train.py --dataset PAPILA --base_architecture resnet34 --batchsize 16 --num_workers 0 --gpu_id 0
elif [ $model == "ppnet" ]
then
    echo "ProtoPNet | ResNet34"
    python code/protopnet/models_train.py --dataset PAPILA --base_architecture resnet34 --batchsize 16 --num_workers 0 --gpu_id 0
elif [ $model == "dppnet" ]
then
    echo "Deformable-ProtoPNet | ResNet34"
    python code/protopnet_deform/models_train.py --dataset PAPILA --base_architecture resnet34 --batchsize 16 --subtractive_margin --using_deform --last_layer_fixed --num_workers 0 --gpu_id 0
else
    echo "Error"
fi
echo "PAPILA | Finished | Training"
