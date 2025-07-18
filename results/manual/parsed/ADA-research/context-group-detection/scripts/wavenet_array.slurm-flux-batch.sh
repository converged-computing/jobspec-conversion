#!/bin/bash
#FLUX: --job-name=train_wave
#FLUX: --queue=gpu-short
#FLUX: -t=3600
#FLUX: --urgency=16

export PYTHONPATH='${PYTHONPATH}:${HOME}/context-group-detection/'

config="./config/wavenet_pede.yml"
model="nri_pede"
fold=-1
epochs=200
original=false
while getopts "m:c:f:e:o" flag; do
  case ${flag} in
  m) model="${OPTARG}" ;;
  c) config="${OPTARG}" ;;
  f) fold="${OPTARG}" ;;
  e) epochs="${OPTARG}" ;;
  o) original=true ;;
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
echo "Using config file at: ${config}, fold: ${fold}, epochs: ${epochs}, seed: ${SLURM_ARRAY_TASK_ID}, original: ${original}"
fold_flag=""
if [ ${fold} != -1 ]; then
  fold_flag="--split ${fold}"
fi
encoder_flag="--encoder wavenetsym --use-motion"
if [ ${original} == false ]; then
  encoder_flag="--encoder cnn"
fi
echo "Script starting"
cd "${HOME}/data1/context-group-detection/models/WavenetNRI/" || exit
python ${model}.py -c ${config} ${fold_flag} --epochs ${epochs} --seed ${SLURM_ARRAY_TASK_ID} ${encoder_flag}
echo "Script finished"
