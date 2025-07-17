#!/bin/bash
#FLUX: --job-name=llama-cpp-label-mixtral
#FLUX: -c=20
#FLUX: -t=1800
#FLUX: --urgency=16

HOSTNAME=$(hostname)
if [ "$HOSTNAME" == "vega.iiia.csic.es" ]
then
    spack load --first py-pandas
elif [ "$HOSTNAME" == "login*" ]
then
    module load pandas
fi
cmd=label-mixtral-$SLURM_JOB_ID.cmd
srun python3 label.py --model "models/mixtral-8x7b-instruct-v0.1.Q4_K_M.gguf" --cmd $cmd
bash $cmd
