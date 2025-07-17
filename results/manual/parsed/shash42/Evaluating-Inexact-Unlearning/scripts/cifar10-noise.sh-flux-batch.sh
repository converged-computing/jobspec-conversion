#!/bin/bash
#FLUX: --job-name=strawberry-signal-6456
#FLUX: -t=345600
#FLUX: --urgency=16

cat cifar10-noise.sh
logdir='logs/Final-cifar10-resnet110'
seed=1
dataset='cifar10'
model='resnet110'
num_classes=10
minlr_og=5e-3
maxlr_og=0.1
num_change=$1
expname="Conf-Noise-$num_change[$minlr_og, $maxlr_og]_Batch64_62eps"
scheduler='CosineAnnealingWarmRestarts'
reg_tr='none'
reg_un='none'
rf_L=1
rf_R=10
rf_S=9
ftF_L=1
ftF_R=10
ftF_S=9
epochs_rf=62
epochs_ft=30
epochs_ftF=$epochs_ft
pathsout_tr="$logdir/$expname/train-paths.txt"
path_oarg=$(sed -n 1p "$pathsout_tr")
path_rarg=$(sed -n 2p "$pathsout_tr")
path_o=$(sed -n 3p "$pathsout_tr")
path_r=$(sed -n 4p "$pathsout_tr")
path_init=$(sed -n 5p "$pathsout_tr")
minlr_ft=$minlr_og
maxlr_ft=$maxlr_og
name_go='Golatkar'
name_rf="RetrFinal_L[$rf_L, $rf_R, $rf_S]_${epochs_rf}ep"
name_ft="Finetune_LR[$minlr_ft, $maxlr_ft]_${epochs_ft}ep"
name_ftF="FinetuneFinal_L[$ftF_L, $ftF_R, $ftF_S]_${epochs_ftF}ep"
pathsout_un="$logdir/$expname/unlearn-paths.txt"
path_ntk=$(sed -n 1p "$pathsout_un")
path_fish=$(sed -n 2p "$pathsout_un")
path_ntkf=$(sed -n 3p "$pathsout_un")
path_ft="$(sed -n 4p "$pathsout_un")"
prefix_rf=$(sed -n 5p "$pathsout_un")
prefix_ftF=$(sed -n 6p "$pathsout_un")
chmod +x src/evaluation.py
CUDA_VISIBLE_DEVICES=$(nvidia-smi --query-gpu=memory.free --format=csv,nounits,noheader | nl -v 0 | sort -nrk 2 | cut -f 1 | head -n 1 | xargs)\
 python3 src/evaluation.py\
 --path-o="$path_o"\
 --path-r="$path_r"\
 --path-oarg="$path_oarg"\
 --path-rarg="$path_rarg"\
 --num-classes=$num_classes\
 --no-ogre\
 --golatkar=False --name-go="$name_go" --path-ntk="$path_ntk" --path-fisher="$path_fish" --path-ntkfisher="$path_ntkf"\
 --retrfinal=False --name-rf="$name_rf" --minL-rf=$rf_L --maxL-rf=$rf_R --stepL-rf=$rf_S --prefix-rf="$prefix_rf"\
 --finetune=False --name-ft="$name_ft" --path-ft="$path_ft"\
 --finetune-final=True --name-ftF="$name_ftF" --minL-ftF=$ftF_L --maxL-ft=$ftF_R --stepL-ftF=$ftF_S --prefix-ftF="$prefix_ftF"
