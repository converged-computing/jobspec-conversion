#!/bin/bash
#FLUX: --job-name=df-parallel-benchmark
#FLUX: --queue=gpu-shared
#FLUX: -t=28800
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
RESULT_DIR="${REPO_DIR}/results"
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
conda install -c conda-forge papermill
cd ${NOTEBOOK_DIR}
mkdir -p "${RESULT_DIR}"
declare -a copies=("1" "2" "4" "8" "16")
declare -a dataframes=("Dask" "Spark" "DaskCuda")
for n_copies in "${copies[@]}"
do
  # download dataset in csv format
  papermill 1-DownloadData.ipynb "${RESULT_DIR}"/1-DownloadData.ipynb -p n_copies $n_copies
  # convert dataset to parquet format
  papermill 1a-Csv2Parquet.ipynb "${RESULT_DIR}"/1a-Csv2Parquet.ipynb
  # run benchmarks
  # Pandas and Cuda dataframes don't utilize multiple cores
  papermill 7-ParallelEfficiency.ipynb "${RESULT_DIR}"/7-ParallelEfficiency.ipynb -p file_format  csv -p dataframe Pandas
  papermill 7-ParallelEfficiency.ipynb "${RESULT_DIR}"/7-ParallelEfficiency.ipynb -p file_format  parquet -p dataframe Pandas
  papermill 7-ParallelEfficiency.ipynb "${RESULT_DIR}"/7-ParallelEfficiency.ipynb -p file_format  csv -p dataframe Cuda
  papermill 7-ParallelEfficiency.ipynb "${RESULT_DIR}"/7-ParallelEfficiency.ipynb -p file_format  parquet -p dataframe Cuda
  n_cores=16
  for dataframe in "${dataframes[@]}"
  do
    file_format=csv
    papermill 7-ParallelEfficiency.ipynb "${RESULT_DIR}"/7-ParallelEfficiency.ipynb -p n_cores $n_cores -p file_format  $file_format -p dataframe $dataframe
    file_format=parquet
    papermill 7-ParallelEfficiency.ipynb "${RESULT_DIR}"/7-ParallelEfficiency.ipynb -p n_cores $n_cores -p file_format $file_format -p dataframe $dataframe
  done
done
