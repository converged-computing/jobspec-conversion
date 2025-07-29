#!/bin/bash
#SBATCH --job-name=mh
#SBATCH --output=logs/res_%j.out
#SBATCH --error=logs/res_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:rtx8000:1
#SBATCH --mem=48GB
#SBATCH --time=05:00:00
#SBATCH --constraint=ntasks-per-node=4

export HF_TOKEN='$(cat hf_token.txt)'

export HF_TOKEN=$(cat hf_token.txt)
overlay=/scratch/ad6489/pyexample/overlay2
img=/scratch/work/public/singularity/cuda11.0-cudnn8-devel-ubuntu18.04.sif
singularity exec --nv \
	--overlay $overlay:ro \
	$img \
    /bin/bash -c \
	"source /ext3/env.sh; \
	python mh.py"
