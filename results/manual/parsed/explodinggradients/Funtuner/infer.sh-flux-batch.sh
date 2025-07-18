#!/bin/bash
#FLUX: --job-name=RM
#FLUX: -n=8
#FLUX: --queue=gpu_v100
#FLUX: -t=3600
#FLUX: --urgency=16

export PYTHONPATH='${PYTHONPATH}:/home/c.scmse/Funtuner'

git pull origin dev-train 
module purge
module load deepspeed
module list
export PYTHONPATH="${PYTHONPATH}:/home/c.scmse/Funtuner"
exec singularity exec --nv $DEEPSPEED_IMAGE /nfshome/store03/users/c.scmse/venv/bin/python funtuner/sampling.py --model_url shahules786/Redpajama-3B-CoT --dataset Dahoas/cot_gsm8k 
exec singularity exec --nv $DEEPSPEED_IMAGE /nfshome/store03/users/c.scmse/venv/bin/python evals/sampler.py --model_url shahules786/Redpajama-3B-CoT 
