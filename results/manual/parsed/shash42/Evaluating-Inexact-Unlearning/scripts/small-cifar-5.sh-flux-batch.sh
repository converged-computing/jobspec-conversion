#!/bin/bash
#FLUX: --job-name=buttery-carrot-8922
#FLUX: -t=345600
#FLUX: --urgency=16

logdir='logs/smallcifar5-resnet20-debug'
dataset='small_cifar5'
model='resnet20'
path_pre="logs/cifar100-resnet20-pretrain62.pt" #MAKE SURE ADDED TO TRAIN COMMAND
num_classes=5
minlr_og=5e-4
maxlr_og=0.01
confA=$1
confB=$2
num_change=$3
expname="Conf-C$confA-C$confB-$num_change[$minlr_og, $maxlr_og]_Batch64_62eps"
scheduler='CosineAnnealingWarmRestarts'
reg_tr='none'
reg_un='none'
rf_L=1
rf_R=11
rf_S=3
ftF_L=1
ftF_R=11
ftF_S=3
epochs_rf=62
epochs_ft=30
epochs_ftF=$epochs_ft
CUDA_VISIBLE_DEVICES=$(nvidia-smi --query-gpu=memory.free --format=csv,nounits,noheader | nl -v 0 | sort -nrk 2 | cut -f 1 | head -n 1 | xargs)\
 python3 src/train.py --log-dir="$logdir" --exp-name="$expname"\
 --dataset="$dataset" --model="$model" --num-classes=$num_classes\
 --path-pre="$path_pre"\
 --minlr-og="$minlr_og" --maxlr-og="$maxlr_og" --scheduler="$scheduler" --regularization="$reg_tr"\
 --confname="C$confA-C$confB-$num_change" --num-change=$num_change --exch-classes $confA $confB
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
 --golatkar=False --name-go="$name_go" --path-ntk="$path_ntk" --path-fisher="$path_fish" --path-ntkfisher="$path_ntkf"\
 --retrfinal=True --name-rf="$name_rf" --minL-rf=$rf_L --maxL-rf=$rf_R --stepL-rf=$rf_S --prefix-rf="$prefix_rf"\
 --finetune=False --name-ft="$name_ft" --path-ft="$path_ft"\
 --finetune-final=True --name-ftF="$name_ftF" --minL-ftF=$ftF_L --maxL-ft=$ftF_R --stepL-ftF=$ftF_S --prefix-ftF="$prefix_ftF"
