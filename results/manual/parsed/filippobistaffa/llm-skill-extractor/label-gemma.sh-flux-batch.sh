#!/bin/bash
#FLUX: --job-name=llama-cpp-label-gemma
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
cmd=label-gemma-$SLURM_JOB_ID.cmd
srun python3 label.py --model "models/gemma-7b-it-Q4_K_M.gguf" --cmd $cmd
bash $cmd
