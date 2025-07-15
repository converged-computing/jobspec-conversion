#!/bin/bash
#FLUX: --job-name=eve_training
#FLUX: -c=2
#FLUX: --urgency=16

export dms_index='$SLURM_ARRAY_TASK_ID'
export model_parameters_location='../../proteingym/baselines/EVE/EVE/default_model_params.json'
export training_logs_location='../../proteingym/baselines/EVE/logs/'
export DMS_index='${SLURM_ARRAY_TASK_ID}'
export clinical_reference_file_path='$clinical_reference_file_path_subs'

                                           # -N 1 means all cores will be on the same node)
set -eo pipefail # fail fully on first line failure (from Joost slurm_for_ml)
module load miniconda3/4.10.3
module load gcc/6.2.0
module load cuda/10.2
source ../zero_shot_config.sh
source activate proteingym_env
export dms_index=$SLURM_ARRAY_TASK_ID
echo "SLURM_ARRAY_TASK_ID: $SLURM_ARRAY_TASK_ID"
export model_parameters_location='../../proteingym/baselines/EVE/EVE/default_model_params.json'
export training_logs_location='../../proteingym/baselines/EVE/logs/'
export DMS_index=${SLURM_ARRAY_TASK_ID}
export clinical_reference_file_path=$clinical_reference_file_path_subs
python ../../proteingym/baselines/EVE/train_VAE.py \
    --MSA_data_folder ${clinical_MSA_data_folder_subs} \
    --DMS_reference_file_path ${clinical_reference_file_path} \
    --protein_index "${DMS_index}" \
    --MSA_weights_location ${clinical_MSA_weights_folder_subs} \
    --VAE_checkpoint_location ${clinical_EVE_model_folder} \
    --model_parameters_location ${model_parameters_location} \
    --training_logs_location ${training_logs_location} \
    --threshold_focus_cols_frac_gaps 1 \
    --seed 0 \
    --skip_existing \
    --experimental_stream_data \
    --force_load_weights
echo "Done"
