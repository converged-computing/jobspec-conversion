#!/bin/bash
#FLUX: --job-name=dynadojo_run
#FLUX: -t=150
#FLUX: --urgency=16

PARAMS_FILE=$1
JOBS=$2 #default to None if not provided
if [[ $DD_CLUSTER == "quest" ]]; then # if quest cluster, load singularity module
    module load singularity
fi
if [[ $SLURM_ARRAY_TASK_ID == "" ]]; then # if running via srun
    SLURM_ARRAY_TASK_ID=0
fi
if [[ $SLURM_ARRAY_TASK_MAX == "" ]]; then # if running via srun
    SLURM_ARRAY_TASK_MAX=0
fi
singularity run --bind $DD_REPO_DIR/dynadojo/experiments:/dynadojo/experiments \
                --bind $DD_SCRATCH_DIR/$DD_OUTPUT_DIR:/dynadojo/experiments/outputs \
                --bind $DD_REPO_DIR/dynadojo/src/dynadojo:/dynadojo/pkgs/dynadojo \
                --pwd /dynadojo \
                $DD_SINGULARITY_IMAGE_LOCATION/dynadojo_cluster.sif \
                python -u -m experiments \
                    run \
                        --params_file=$PARAMS_FILE \
                        --node=$SLURM_ARRAY_TASK_ID \
                        --total_nodes=$SLURM_ARRAY_TASK_MAX \
                        --num_cpu_parallel=$SLURM_CPUS_PER_TASK \
                        --jobs=$JOBS
