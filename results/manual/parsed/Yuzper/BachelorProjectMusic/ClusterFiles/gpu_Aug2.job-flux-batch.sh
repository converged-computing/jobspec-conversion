#!/bin/bash
#FLUX: --job-name=Aug2_CRNN_Model
#FLUX: -c=8
#FLUX: --queue=brown
#FLUX: -t=180000
#FLUX: --urgency=16

echo "Running on $(hostname):"
module load singularity
pip install tensorcross
singularity exec --nv /opt/itu/containers/tensorflow/tensorflow-23.05-tf2-py3.sif python ClusterTrainingAug2.py
