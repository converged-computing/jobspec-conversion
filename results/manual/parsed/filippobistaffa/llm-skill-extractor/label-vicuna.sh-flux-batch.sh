#!/bin/bash
#FLUX: --job-name=llama-cpp-label-vicuna
#FLUX: -c=20
#FLUX: -t=1800
#FLUX: --priority=16

HOSTNAME=$(hostname)
if [ "$HOSTNAME" == "vega.iiia.csic.es" ]
then
    spack load --first py-pandas
elif [ "$HOSTNAME" == "login*" ]
then
    module load pandas
fi
cmd=label-vicuna-$SLURM_JOB_ID.cmd
srun python3 label.py --model "models/vicuna-13b-v1.5-16k.Q4_K_M.gguf" --cmd $cmd
bash $cmd
