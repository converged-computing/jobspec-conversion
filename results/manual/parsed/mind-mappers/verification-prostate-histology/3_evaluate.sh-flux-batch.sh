#!/bin/bash
#FLUX: --job-name=strawberry-house-5641
#FLUX: --queue=teaching
#FLUX: --urgency=16

toanalyze="att10_unmaskedgood"
model_name="model"
logdir="./homologous_point_prediction/outputs/${toanalyze}"
args="${logdir} ${model_name}"
container="/data/containers/msoe-tensorflow-20.07-tf2-py3.sif"
command="python3 ./evaluate_run.py ${args}"
singularity exec --nv -B /data:/data ${container} ${command}
mv ./homologous_point_prediction/outputs/running/slurm-${SLURM_JOBID}.out "${logdir}/evaluate_raw_slurm_out.out "
