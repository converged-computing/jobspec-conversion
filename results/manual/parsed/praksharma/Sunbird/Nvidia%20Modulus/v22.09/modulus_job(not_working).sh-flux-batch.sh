#!/bin/bash
#FLUX: --job-name=jupyter-lab
#FLUX: -c=2
#FLUX: --queue=accel_ai
#FLUX: -t=18000
#FLUX: --urgency=16

port=8888
node=$(hostname -s)
user=$(whoami)
module load apptainer/1.0.3 
apptainer exec --contain --nv --cleanenv --bind "/home/s.1915438/":/data,/tmp:/tmp --env CUDA_VISIBLE_DEVICES=$CUDA_VISIBLE_DEVICES --home /data  "/home/scratch/s.1915438/modulus22.09_apptainer/modulus_22.09.img" jupyter-lab --no-browser --port=${port} --ip=${node}
