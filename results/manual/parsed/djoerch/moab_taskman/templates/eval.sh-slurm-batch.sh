#!/bin/bash
#SBATCH --account=def-descotea
#SBATCH --output=/home/jord2201/logs/$TASKMAN_NAME.o%j
#SBATCH --error=/home/jord2201/logs/$TASKMAN_NAME.e%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --time=10:00:00

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
