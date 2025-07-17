#!/bin/bash
#FLUX: --job-name=augmented
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=10800
#FLUX: --urgency=16

tiler_type='SharedAugTiler'
path_wsi="./test_dataset/slides"
ext='svs'
path_outputs="./test_dataset/encoded"
model_path="/path/of/the/model/if/using/ssl/for/encoding.pth" 
level=1
size=224
tiler="imagenet" 
normalizer="macenko"
Naug=50
Nt=256
NWSI=10 # Number of WSI per job. set the array so that NWSI * Njobs = total number of WSI
num_worker=8 #Set it as the number of cpus per task
python build_dataset/main_tiling.py --path_wsi "$path_wsi" --ext $ext --level "$level" --tiler "$tiler" --size "$size" --model_path "$model_path" --path_outputs "$path_outputs" --normalizer "$normalizer" --Naug $Naug --Nt $Nt --NWSI $NWSI --tiler_type $tiler_type
