#!/bin/bash
#FLUX: --job-name=PialNet
#FLUX: --queue=gpu
#FLUX: --urgency=16

module load cuda/10.0.130
module load gnu7
module load openmpi3
module load anaconda/3.6
source activate /opt/ohpc/pub/apps/tensorflow_2.0.0
ckp_folder="checkpoints/"
data_folder="dataset/MRA_P09_denoised/"
for ckp in $(ls "francesco/"$ckp_folder)
do
	for res in $(ls "francesco/"$data_folder)
	do
		python3 francesco/src/predict.py --ckp_path $ckp_folder$ckp"/" --ckp_name test-loss --input_path $data_folder$res
	done
done
