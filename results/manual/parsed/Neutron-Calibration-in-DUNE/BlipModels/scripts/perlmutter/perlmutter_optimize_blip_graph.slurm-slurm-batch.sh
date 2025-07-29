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
#SBATCH --array=0-2
#SBATCH --dependency=<optimize_blip_graph_prep_id>

export LOCAL_SCRATCH='/pscratch/sd/${USER:0:1}/${USER}/$SLURM_JOB_ID/$SLURM_ARRAY_TASK_ID'

export LOCAL_SCRATCH=/pscratch/sd/${USER:0:1}/${USER}/$SLURM_JOB_ID/$SLURM_ARRAY_TASK_ID
mkdir -p $LOCAL_SCRATCH
LOCAL_BLIP=/global/cfs/cdirs/dune/users/${USER}
LOCAL_DATA=/global/cfs/cdirs/dune/users/${USER}
hyper_parameter_file="/local_scratch/hyper_parameter_data.csv"
if [ ! -e "$hyper_parameter_file" ]; then
    echo "Error: Hyper parameter file '$hyper_parameter_file' not found!"
    exit 1
fi
while IFS=',' read -r hyper_parameter_config; do
    # check that line is not empty
    if [ -n "$hyper_parameter_config" ]; then
        sbatch --job-name="$hyper_parameter_config" "$optimization_script" "$hyper_parameter_config"
    fi
done < "$hyper_parameter_file"
setfacl -m u:nobody:x /global/cfs/cdirs/dune/users/${USER}
shifter --image=docker:infophysics/blip:latest \
        --volume="${LOCAL_SCRATCH}:/local_scratch;${LOCAL_BLIP}:/local_blip;${LOCAL_DATA}:/local_data" \
        ./perlmutter_optimize_blip_graph.sh
