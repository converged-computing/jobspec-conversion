#!/bin/bash
#SBATCH --job-name=PialNet
#SBATCH --output=out_wiener.txt
#SBATCH --error=error_wiener.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:tesla-smx2:1
#SBATCH --mem=50000
#SBATCH --partition=gpu

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
