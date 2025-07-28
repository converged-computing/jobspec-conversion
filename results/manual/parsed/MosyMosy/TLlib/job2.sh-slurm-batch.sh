#!/bin/bash
#FLUX: --job-name=nprior_20_101
#FLUX: -t=480
#FLUX: --urgency=16

export TORCH_HOME='$SLURM_TMPDIR/Pytorch_zoo'

nvidia-smi
source ~/envs/TLlib/bin/activate
echo "change TORCH_HOME environment variable"
cd $SLURM_TMPDIR
cp -r ~/scratch/Pytorch_zoo .
export TORCH_HOME=$SLURM_TMPDIR/Pytorch_zoo
echo "------------------------------------< Data preparation>----------------------------------"
echo "Copying the source code"
date +"%T"
cd $SLURM_TMPDIR
cp -r ~/scratch/TLlib .
echo "Copying the datasets"
date +"%T"
cd $SLURM_TMPDIR
cp -r ~/scratch/TLlib_Dataset .
date +"%T"
echo "----------------------------------< End of data preparation>--------------------------------"
date +"%T"
echo "--------------------------------------------------------------------------------------------"
echo "---------------------------------------<Run the program>------------------------------------"
date +"%T"
cd $SLURM_TMPDIR
cd TLlib
cd examples/domain_adaptation/image_classification
CUDA_VISIBLE_DEVICES=0 python nprior.py $SLURM_TMPDIR/TLlib_Dataset/office31 -d Office31 -s A -t W -a resnet50 --epochs 20 --seed 1 --log $SLURM_TMPDIR/TLlib/logs/nprior_20_101/Office31_A2W --ce_weight 0
echo "-----------------------------------<End of run the program>---------------------------------"
date +"%T"
echo "--------------------------------------<backup the result>-----------------------------------"
date +"%T"
cp -r $SLURM_TMPDIR/TLlib/logs/nprior_20_101 ~/scratch/TLlib/logs/nprior_20_101
