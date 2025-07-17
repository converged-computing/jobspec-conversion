#!/bin/bash
#FLUX: --job-name=df-parallel
#FLUX: --queue=gpu-shared
#FLUX: -t=900
#FLUX: --urgency=16

export LOCAL_SCRATCH_DIR='/scratch/${USER}/job_${SLURM_JOB_ID}'
export CONDA_INSTALL_PATH='${LOCAL_SCRATCH_DIR}/miniconda3'
export CONDA_ENVS_PATH='${CONDA_INSTALL_PATH}/envs'
export CONDA_PKGS_DIRS='${CONDA_INSTALL_PATH}/pkgs'

module purge
module load slurm
module load gpu 
CONDA_ENV=df-parallel-gpu
REPO_DIR=${HOME}/df-parallel
CONDA_YML="${REPO_DIR}/environment-gpu.yml"
NOTEBOOK_DIR="${REPO_DIR}/notebooks"
RESULT_DIR="${NOTEBOOK_DIR}/results"
export LOCAL_SCRATCH_DIR="/scratch/${USER}/job_${SLURM_JOB_ID}"
if [ ! -f "Miniconda3-latest-Linux-x86_64.sh" ]; then
   wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
   chmod +x Miniconda3-latest-Linux-x86_64.sh
fi
export CONDA_INSTALL_PATH="${LOCAL_SCRATCH_DIR}/miniconda3"
export CONDA_ENVS_PATH="${CONDA_INSTALL_PATH}/envs"
export CONDA_PKGS_DIRS="${CONDA_INSTALL_PATH}/pkgs"
./Miniconda3-latest-Linux-x86_64.sh -b -p "${CONDA_INSTALL_PATH}"
source "${CONDA_INSTALL_PATH}/etc/profile.d/conda.sh"
conda install mamba -n base -c conda-forge
mamba env create -f ${CONDA_YML}
conda activate ${CONDA_ENV}
cd ${NOTEBOOK_DIR}
rm -rf "${RESULT_DIR}"
mkdir -p "${RESULT_DIR}"
papermill 1-FetchDataCIML2023.ipynb "${RESULT_DIR}"/1-FetchDataCIML2023.ipynb
papermill <your_code_here>
papermill <your_code_here>
papermill <your_code_here>
papermill <your_code_here>
papermill <your_code_here>
conda deactivate
