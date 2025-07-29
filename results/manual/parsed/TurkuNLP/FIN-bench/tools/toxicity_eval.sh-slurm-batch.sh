#!/bin/bash
#FLUX: --job-name=run_eval
#FLUX: -c=60
#FLUX: --exclusive
#FLUX: --queue=small-g
#FLUX: -t=9000
#FLUX: --urgency=16

export NCCL_SOCKET_IFNAME='hsn'
export CACHE_DIR='/scratch/project_462000185/risto/huggingface-t5-checkpoints/cache_dir/'
export TRANSFORMERS_OFFLINE='1'
export PYTHONUSERBASE='.'

set -x
rm -f logs/latest.out logs/latest.err
ln -s toxicity-eval-$SLURM_JOB_NAME-$SLURM_JOBID.out logs/latest.out
ln -s toxicity-eval-$SLURM_JOB_NAME-$SLURM_JOBID.err logs/latest.err
export NCCL_SOCKET_IFNAME=hsn
export CACHE_DIR=/scratch/project_462000185/risto/huggingface-t5-checkpoints/cache_dir/
export TRANSFORMERS_OFFLINE=1
module load cray-python
export PYTHONUSERBASE="."
source /scratch/project_462000119/risto/venv/bin/activate
TF_CPP_MIN_LOG_LEVEL=0 
python3 toxicity_eval.py \
    --tokenizer "bert-base-finnish-cased-v1" \
    --data $1 \
    --model "finbert-large-deepl/" \
