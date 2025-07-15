#!/bin/bash
#FLUX: --job-name=chunky-puppy-9326
#FLUX: --queue=ml
#FLUX: -t=288000
#FLUX: --urgency=16

export PYTHONPATH='$PYTHONPATH:/scratch/ws/1/s8732099-da/git/gaea_release/AutoDL-Projects'

module load modenv/ml
module load torchvision/0.7.0-fosscuda-2019b-Python-3.7.4-PyTorch-1.6.0
source /scratch/ws/1/s8732099-da/.venv/gaea/bin/activate
export PYTHONPATH=$PYTHONPATH:/scratch/ws/1/s8732099-da/git/gaea_release/AutoDL-Projects
python /scratch/ws/1/s8732099-da/git/gaea_release/cnn/experiments_da.py \
    mode=grid_search \
    method.mode=sequential \
    run_search_phase.seed=1431 \
    run_eval_phase.seed=1431 \
    run_search_phase.data=/scratch/ws/1/s8732099-da/data \
    run_eval_phase.data=/scratch/ws/1/s8732099-da/data \
    run_search_phase.autodl=/scratch/ws/1/s8732099-da/git/gaea_release/AutoDL-Projects \
    run_eval_phase.autodl=/scratch/ws/1/s8732099-da/git/gaea_release/AutoDL-Projects \
    hydra.run.dir=/scratch/ws/1/s8732099-da/experiments_da/\${method.name}
exit 0
