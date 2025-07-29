#!/bin/bash
#FLUX: --job-name=grid_search_sequential_seed_3030
#FLUX: --queue=alpha
#FLUX: -t=216000
#FLUX: --urgency=16

export PYTHONPATH='$PYTHONPATH:/scratch/ws/1/s8732099-da/git/gaea_release/AutoDL-Projects'

module load modenv/hiera GCC/10.2.0 CUDA/11.1.1 OpenMPI/4.0.5 PyTorch/1.7.1
source /scratch/ws/1/s8732099-da/.venv/gaea_alpha/bin/activate
export PYTHONPATH=$PYTHONPATH:/scratch/ws/1/s8732099-da/git/gaea_release/AutoDL-Projects
python /scratch/ws/1/s8732099-da/git/gaea_release/cnn/experiments_da.py \
    mode=grid_search \
    method.mode=sequential \
    run_search_phase.seed=3030 \
    run_eval_phase.seed=3030 \
    run_search_phase.data=/scratch/ws/1/s8732099-da/data \
    run_eval_phase.data=/scratch/ws/1/s8732099-da/data \
    run_search_phase.autodl=/scratch/ws/1/s8732099-da/git/gaea_release/AutoDL-Projects \
    run_eval_phase.autodl=/scratch/ws/1/s8732099-da/git/gaea_release/AutoDL-Projects \
    hydra.run.dir=/scratch/ws/1/s8732099-da/experiments_da/\${method.name}
exit 0
