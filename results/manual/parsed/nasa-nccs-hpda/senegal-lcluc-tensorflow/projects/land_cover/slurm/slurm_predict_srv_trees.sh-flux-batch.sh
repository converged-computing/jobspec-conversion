#!/bin/bash
#FLUX: --job-name=chunky-poo-1825
#FLUX: --urgency=16

export PYTHONPATH='/adapt/nobackup/people/jacaraba/development/tensorflow-caney'

module load anaconda
conda activate ilab
export PYTHONPATH="/adapt/nobackup/people/jacaraba/development/tensorflow-caney"
srun -G1 -n1 python /adapt/nobackup/people/jacaraba/development/senegal-lcluc-tensorflow/projects/land_cover/scripts/predict.py \
	-c /adapt/nobackup/people/jacaraba/development/senegal-lcluc-tensorflow/projects/land_cover/configs/20220620/land_cover_256_trees_srv.yaml
