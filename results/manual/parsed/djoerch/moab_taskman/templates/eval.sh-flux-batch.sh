#!/bin/bash
#FLUX: --job-name=gloopy-lentil-2642
#FLUX: -c=4
#FLUX: -t=36000
#FLUX: --urgency=16

export HANGUP_TIME='$(($(date +"%s") + 10 * 3600))'

module load singularity
export HANGUP_TIME=$(($(date +"%s") + 10 * 3600))
cd ${HOME}/git/repositories/vslic/containerization/singularity
bash vslic_run_in_singularity.sh \
  --data-mount-path ${SCRATCH}/vslic_test_dir \
  --venv-mount-path ${SCRATCH}/vslic_test_venv_3 \
  --code-mount-path ${HOME}/git/repositories/vslic \
  --singularity-image ${SCRATCH}/vslic-3.sif \
  vslic_eval_model.py -c ${SCRATCH}/vslic_test_dir/configs/$TASKMAN_ARGS
