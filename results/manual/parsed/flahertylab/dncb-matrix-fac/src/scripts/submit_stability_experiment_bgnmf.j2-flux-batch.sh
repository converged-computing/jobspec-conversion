#!/bin/bash
#FLUX: --job-name={{
#FLUX: --urgency=16

DOCKER_IMAGE=dncb-fac-image
CONTAINER_NAME=dncb-fac-container
MLFLOW_EXPERIMENT_NAME=stability_experiment_bgnmf
module load jq
job_config_file="{{ experiment_config_json }}"
{% raw %}
job_config=$(jq -r ".[${SLURM_ARRAY_TASK_ID}]" $job_config_file)
data_path=$(echo $job_config | jq -r ".data_path")
uuid=$(echo $job_config | jq -r ".uuid")
docker run --rm -v /data/projects/dncbtd:/work/data -v ./results/stability_experiment_bgnmf:/work/data/tmp  \
    --env MLFLOW_EXPERIMENT_NAME=${MLFLOW_EXPERIMENT_NAME} ${DOCKER_IMAGE} \
    python src/dncbfac/stability_experiment_bgnmf.py "${job_config}"
{% endraw %}
