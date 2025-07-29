#!/bin/bash
#SBATCH --job-name=dl-test
#SBATCH --account=nstaff
#SBATCH --output=shifter_job_log_%j.out
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --time=00:10:00
#SBATCH --constraint=gpu,ntasks-per-node=4

export MASTER_ADDR='$(hostname)'

singularity
exec
nersc/pytorch:ngc-23.07-v0
config_file=./configs/default.yaml
config="default"
run_num="ddp-shifter"
env=/global/homes/s/shas1693/.local/perlmutter/nersc_pytorch_ngc_23_07_v0
export MASTER_ADDR=$(hostname)
cmd="python train_multi_gpu.py --yaml_config=$config_file --config=$config --run_num=$run_num"
set -x
srun -l shifter --env PYTHONUSERBASE=${env} \
    bash -c "
    source export_DDP_vars.sh
    $cmd
    " 
