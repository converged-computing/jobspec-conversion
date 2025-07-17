#!/bin/bash
#FLUX: --job-name=compute_stac
#FLUX: -c=8
#FLUX: -t=45
#FLUX: --urgency=16

img_path="/n/home02/daldarondo/LabDir/Diego/.images/mj_stac.sif"
param_path=$1; shift
save_path=$1; shift
offset_path=$1; shift
data_path=( "$@" )
echo singularity exec $img_path bash /home/compute_stac.sh ${data_path[$SLURM_ARRAY_TASK_ID]} $param_path $save_path $offset_path
singularity exec $img_path bash /home/compute_stac.sh ${data_path[$SLURM_ARRAY_TASK_ID]} $param_path $save_path $offset_path
