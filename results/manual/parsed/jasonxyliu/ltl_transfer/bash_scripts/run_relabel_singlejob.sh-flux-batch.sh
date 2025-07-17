#!/bin/bash
#FLUX: --job-name=arid-malarkey-1334
#FLUX: -N=3
#FLUX: -n=144
#FLUX: -t=356400
#FLUX: --urgency=16

export PYTHONUNBUFFERED='TRUE'

export PYTHONUNBUFFERED=TRUE
algo="zero_shot_transfer"
train_type="mixed"
train_size=50
test_type="mixed"
map=5
prob=0.9
edge_matcher="relaxed"
run_id=0
relabel_method="cluster"
save_dpath="$HOME/data/shared/ltl-transfer"
module load anaconda/2022.05
source /oscar/runtime/opt/anaconda/2022.05/etc/profile.d/conda.sh
conda activate ltl_transfer
module load mpi/openmpi_4.0.7_gcc_10.2_slurm22
srun --mpi=pmix python -m mpi4py.futures src/run_experiments.py --algo=$algo --train_type=$train_type --train_size=$train_size --test_type=$test_type --map=$map --prob=$prob --run_id=$run_id --relabel_method=$relabel_method --edge_matcher=$edge_matcher --save_dpath=$save_dpath
