#!/bin/bash
#SBATCH --job-name=runctonaineraigj
#SBATCH --output=job_%j.out
#SBATCH --error=job_%j.err
#SBATCH --mail-user=[your
#SBATCH --mail-type=ALL
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=28672
#SBATCH --time=04:00:00

module load singularity/3.5.3
cd [your folder with the container]
imag_directory="[file path to images]"
imag_savesegmented="[file path to save segmentations]"
mode="nuclei"
flow_threshold=0
cellprob_threshold=-1
celldiameter=19
channel=1
singularity run cellpose_container.sif --filedir $imag_directory --savedir $imag_savesegmented --pretrained_model $mode --flow_threshold $flow_threshold --cellprob_threshold $cellprob_threshold --diameter $celldiameter --chan $channel --save_tif
