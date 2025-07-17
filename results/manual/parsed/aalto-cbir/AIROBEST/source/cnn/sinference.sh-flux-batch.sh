#!/bin/bash
#FLUX: --job-name=inference5
#FLUX: --queue=gpu
#FLUX: -t=259200
#FLUX: --urgency=16

id -a
module purge
module load pytorch/1.4
module list
python -W ignore -u inference.py -model_path ./checkpoint/S1-27_only_fertility_class/model_e150_nan.pt -save_dir ./inference/S1-27_only_fertility_class -gpu 0
echo -e "\n ... printing job stats .... \n"
used_slurm_resources.bash
