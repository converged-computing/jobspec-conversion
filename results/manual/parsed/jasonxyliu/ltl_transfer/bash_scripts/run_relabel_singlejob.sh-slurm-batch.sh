#!/bin/bash
#SBATCH --output=sbatch_out/job-%j.out
#SBATCH --error=sbatch_out/job-%j.err
#SBATCH --mail-user=xinyu_liu@brown.edu
#SBATCH --mail-type=BEGIN,END,FAIL,TIME_LIMIT_90
#SBATCH --nodes=3
#SBATCH --ntasks=144
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=20G
#SBATCH --time=4-03:00:00

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
