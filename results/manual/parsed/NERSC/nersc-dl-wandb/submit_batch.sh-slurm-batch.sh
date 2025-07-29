#!/bin/bash
#SBATCH --job-name=dl-wandb-test
#SBATCH --account=<your_account>
#SBATCH --output=job_log_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --time=01:00:00
#SBATCH --constraint=gpu,ntasks-per-node=4

export FI_MR_CACHE_MONITOR='userfaultfd'
export HDF5_USE_FILE_LOCKING='FALSE'
export NCCL_NET_GDR_LEVEL='PHB'
export MASTER_ADDR='$(hostname)'

singularity
exec
nersc/pytorch:ngc-22.09-v0
config_file=./config/default.yaml
config="test2"
run_num="0"
env=/global/homes/s/shas1693/.local/perlmutter/nersc_pytorch_ngc-22.09-v0
export FI_MR_CACHE_MONITOR=userfaultfd
export HDF5_USE_FILE_LOCKING=FALSE
export NCCL_NET_GDR_LEVEL=PHB
export MASTER_ADDR=$(hostname)
scratch="$SCRATCH/results/logging_tests/"
cmd="python train.py --yaml_config=$config_file --config=$config --run_num=$run_num --root_dir=$scratch"
set -x
srun -l shifter --env PYTHONUSERBASE=${env} \
    bash -c "
    source export_DDP_vars.sh
    $cmd
    " 
