#!/bin/bash
#FLUX: --job-name=job_id_144
#FLUX: -t=36000
#FLUX: --urgency=16

    echo "SLURM_JOB_ID: ${SLURM_JOB_ID}"
    echo "SLURM_SUBMIT_DIR: ${SLURM_SUBMIT_DIR}"
    echo "RECORDING_PROCESS_ID: ${recording_process_id}"
    echo "RAW_DATA_DIRECTORY: ${raw_data_directory}"
    echo "PROCESSED_DATA_DIRECTORY: ${processed_data_directory}"
    echo "REPOSITORY_DIR: ${repository_dir}"
    echo "PROCESS_SCRIPT_PATH: ${process_script_path}"
    module load anaconda3/5.3.1
    module load matlab/R2020a
    conda activate /home/alvaros/.conda/envs/BrainCogsEphysSorters_env
    cd ${repository_dir}
    python ${process_script_path}
