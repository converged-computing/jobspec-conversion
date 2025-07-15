#!/bin/bash
#FLUX: --job-name=train_gan
#FLUX: --queue=gpu-short
#FLUX: -t=1800
#FLUX: --priority=16

export PYTHONPATH='${PYTHONPATH}:${HOME}/context-group-detection/'

config="./config/gdgan_pede.yml"
model="gdgan_pede"
fold=-1
epochs=200
while getopts "m:c:f:e:" flag; do
  case ${flag} in
  m) model="${OPTARG}" ;;
  c) config="${OPTARG}" ;;
  f) fold="${OPTARG}" ;;
  e) epochs="${OPTARG}" ;;
  *)
    echo "Invalid flag: ${flag}" >&2
    exit 1
    ;;
  esac
done
module load PyTorch/1.12.1-foss-2022a-CUDA-11.7.0
module load PyYAML/6.0-GCCcore-11.3.0
pip install scikit-network
export PYTHONPATH="${PYTHONPATH}:${HOME}/context-group-detection/"
echo "User: ${SLURM_JOB_USER}, hostname: ${HOSTNAME}, job_id: ${SLURM_JOB_ID}, array_task_id: ${SLURM_ARRAY_TASK_ID}"
echo "Current working directory: $(pwd)"
echo "Running ${model}"
echo "Using config file at: ${config}, fold: ${fold}, epochs: ${epochs}, seed: ${SLURM_ARRAY_TASK_ID}"
fold_flag=""
if [ ${fold} != -1 ]; then
  fold_flag="--split ${fold}"
fi
echo "Script starting"
cd "${HOME}/data1/context-group-detection/models/GDGAN/" || exit
python ${model}.py -c ${config} ${fold_flag} --epochs ${epochs} --seed ${SLURM_ARRAY_TASK_ID}
echo "Script finished"
