#!/bin/bash
#FLUX: --job-name=sticky-despacito-2316
#FLUX: -t=345600
#FLUX: --urgency=16

cat cifar100-exch.sh
logdir='logs3/Final-cifar100-resnet110'
seed=3
dataset='cifar100'
model='resnet110'
num_classes=100
minlr_og=5e-3
maxlr_og=0.1
confA=$1
confB=$2
num_change=$3
epochs_og=126
expname="Conf-C$confA-C$confB-$num_change[$minlr_og, $maxlr_og]_Batch64_${epochs_og}eps_cutmix"
scheduler='CosineAnnealingWarmRestarts'
reg_tr='cutmix'
reg_un='remove'
rf_L=10
rf_R=50
rf_S=40
ftF_L=10
ftF_R=50
ftF_S=40
epochs_rf=126
epochs_ft=62
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
chmod +x src/unlearn.py
CUDA_VISIBLE_DEVICES=$(nvidia-smi --query-gpu=memory.free --format=csv,nounits,noheader | nl -v 0 | sort -nrk 2 | cut -f 1 | head -n 1 | xargs)\
 python3 src/unlearn.py\
 --path-o="$path_o" --path-r="$path_r" --path-oarg="$path_oarg" --path-rarg="$path_rarg" --init-checkpoint="$path_init"\
 --num-classes=$num_classes --scheduler="$scheduler" --regularization="$reg_un"\
 --golatkar=False --name-go="$name_go"\
 --retrfinal=True --name-rf="$name_rf" --epochs-rf=$epochs_rf --minL-rf=$rf_L --maxL-rf=$rf_R --stepL-rf=$rf_S\
 --finetune=False --name-ft="$name_ft" --epochs-ft=$epochs_ft --minlr-ft="$minlr_ft" --maxlr-ft="$maxlr_ft"\
 --finetune-final=True --name-ftF="$name_ftF" --epochs-ftF=$epochs_ftF --minL-ftF=$ftF_L --maxL-ft=$ftF_R --stepL-ftF=$ftF_S\
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
 --num-classes=$num_classes --exch-classes $confA $confB\
 --no-ogre\
 --golatkar=False --name-go="$name_go" --path-ntk="$path_ntk" --path-fisher="$path_fish" --path-ntkfisher="$path_ntkf"\
 --retrfinal=True --name-rf="$name_rf" --minL-rf=$rf_L --maxL-rf=$rf_R --stepL-rf=$rf_S --prefix-rf="$prefix_rf"\
 --finetune=False --name-ft="$name_ft" --path-ft="$path_ft"\
 --finetune-final=True --name-ftF="$name_ftF" --minL-ftF=$ftF_L --maxL-ft=$ftF_R --stepL-ftF=$ftF_S --prefix-ftF="$prefix_ftF"
