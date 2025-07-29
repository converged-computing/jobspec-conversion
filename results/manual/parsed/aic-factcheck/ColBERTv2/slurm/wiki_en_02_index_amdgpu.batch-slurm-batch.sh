#!/bin/bash
#SBATCH --job-name=wiki_en_02_colbert_index
#SBATCH --output=../logs/wiki_en_02_colbert_index.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=320G
#SBATCH --time=1-00:00:00
#SBATCH --partition=amdgpu

export PYTHONPATH='.:$PYTHONPATH'

echo running on: $SLURM_JOB_NODELIST
if [[ -z "${PROJECT_DIR}" ]]; then
    export PROJECT_DIR="$(dirname "$(pwd)")"
fi
if [ -f "${PROJECT_DIR}/init_environment_hflarge_amd.sh" ]; then
    source "${PROJECT_DIR}/init_environment_hflarge_amd.sh"
fi
cd ${PROJECT_DIR}
pwd
ml GCC/11.2.0
export PYTHONPATH=.:$PYTHONPATH
CFG=cfg/index/wiki_en/index_cedmo_qacg_en_500tokens.config.py
python scripts/build_index.py $CFG
