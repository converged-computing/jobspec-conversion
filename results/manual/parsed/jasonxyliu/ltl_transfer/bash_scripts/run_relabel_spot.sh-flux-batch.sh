#!/bin/bash
#FLUX: --job-name=arid-chip-9569
#FLUX: --urgency=16

export PYTHONUNBUFFERED='TRUE'

export PYTHONUNBUFFERED=TRUE
algo="zero_shot_transfer"
train_type="mixed"
train_size=50
test_type="mixed"
map=20
prob=1.0
run_id=0
relabel_method="cluster"
edge_matcher="relaxed"
save_dpath="$HOME/data/shared/ltl-transfer"
dataset_name="spot"
module load anaconda/2022.05
source /oscar/runtime/opt/anaconda/2022.05/etc/profile.d/conda.sh
conda activate ltl_transfer
module load mpi/openmpi_4.0.7_gcc_10.2_slurm22
srun --mpi=pmix python -m mpi4py.futures src/run_experiments.py --algo=$algo --train_type=$train_type --train_size=$train_size --test_type=$test_type --map=$map  --prob=$prob --run_id=$run_id --relabel_method=$relabel_method --edge_matcher=$edge_matcher --save_dpath=$save_dpath --dataset_name=$dataset_name
