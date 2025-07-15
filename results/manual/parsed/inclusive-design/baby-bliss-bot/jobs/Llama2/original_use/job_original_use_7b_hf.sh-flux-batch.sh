#!/bin/bash
#FLUX: --job-name=llama2-orig-use-7b-hf
#FLUX: -c=4
#FLUX: -t=864000
#FLUX: --urgency=16

pip install --upgrade pip
module load python/3.11.5
python -V
virtualenv --no-download $SLURM_TMPDIR/env
source $SLURM_TMPDIR/env/bin/activate
pip install --upgrade pip
module load StdEnv/2023
module load rust/1.70.0
pip install --no-index transformers==4.36.2
pip install -r ~/llama2/requirements-llama2.txt
python -V
pip list
echo "Llama2 original use from job $SLURM_JOB_ID on nodes $SLURM_JOB_NODELIST."
python ~/llama2/original_use/original_use_7b_hf.py
