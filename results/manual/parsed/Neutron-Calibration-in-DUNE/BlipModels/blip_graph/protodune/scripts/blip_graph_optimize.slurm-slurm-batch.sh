#!/bin/bash
#SBATCH --job-name=blip_graph_test
#SBATCH --account=dune
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --partition=shared
#SBATCH --constraint=gpu
#SBATCH --array=0-9
#SBATCH --dependency=<optimize_blip_graph_prep_id>

export LOCAL_SCRATCH='/pscratch/sd/${USER:0:1}/${USER}/$SLURM_JOB_ID/$SLURM_ARRAY_TASK_ID'

export LOCAL_SCRATCH=/pscratch/sd/${USER:0:1}/${USER}/$SLURM_JOB_ID/$SLURM_ARRAY_TASK_ID
mkdir -p $LOCAL_SCRATCH
LOCAL_BLIP=/global/cfs/cdirs/dune/users/${USER}
LOCAL_DATA=/global/cfs/cdirs/dune/users/${USER}
hyper_parameter_file="${LOCAL_BLIP}/hyper_parameter_data.csv"
if [ ! -e "$hyper_parameter_file" ]; then
    echo "Error: Hyper parameter file '$hyper_parameter_file' not found!"
    exit 1
fi
hyper_parameter_config=$(head -n $((SLURM_ARRAY_TASK_ID+1)) "$hyper_parameter_file" | tail -1 | tr -d '\r')"/hyper_parameter_config.yaml"
setfacl -m u:nobody:x /global/cfs/cdirs/dune/users/${USER}
shifter --image=docker:infophysics/blip:latest \
        --volume="${LOCAL_SCRATCH}:/local_scratch;${LOCAL_BLIP}:/local_blip;${LOCAL_DATA}:/local_data" \
        ./blip_graph_optimize.sh $hyper_parameter_config
