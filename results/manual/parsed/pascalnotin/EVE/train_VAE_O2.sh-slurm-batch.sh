#!/bin/bash
#SBATCH --job-name=EVE
#SBATCH --output=./slurm_stdout/slurm-%j.out
#SBATCH --error=./slurm_stdout/slurm-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --gres=gpu:1
#SBATCH --mem=100G
#SBATCH --time=4-00:00:00
#SBATCH --array=67

export MSA_data_folder='/n/groups/marks/projects/marks_lab_and_oatml/DRP_part_2/MSA_files/MSAs_0B1P'
export MSA_list='/home/pn73/EVE/data/mappings/mapping_evol_indices_wave2.csv'
export MSA_weights_location='/home/pn73/EVE/data/weights'
export VAE_checkpoint_location='/n/groups/marks/projects/marks_lab_and_oatml/trained_model_params/all_trained_models_wave2_Mar10'
export model_name_suffix='Mar10'
export model_parameters_location='/home/pn73/EVE/EVE/default_model_params.json'
export training_logs_location='/home/pn73/EVE/logs/0B1P'

module load gcc/6.2.0
module load cuda/10.1
conda env update --file /home/pn73/EVE/protein_env.yml
source activate protein_env
export MSA_data_folder=/n/groups/marks/projects/marks_lab_and_oatml/DRP_part_2/MSA_files/MSAs_0B1P
export MSA_list='/home/pn73/EVE/data/mappings/mapping_evol_indices_wave2.csv'
export MSA_weights_location=/home/pn73/EVE/data/weights
export VAE_checkpoint_location=/n/groups/marks/projects/marks_lab_and_oatml/trained_model_params/all_trained_models_wave2_Mar10
export model_name_suffix='Mar10'
export model_parameters_location='/home/pn73/EVE/EVE/default_model_params.json'
export training_logs_location=/home/pn73/EVE/logs/0B1P
srun \
    python train_VAE.py \
        --MSA_data_folder ${MSA_data_folder} \
        --MSA_list ${MSA_list} \
        --protein_index $SLURM_ARRAY_TASK_ID \
        --MSA_weights_location ${MSA_weights_location} \
        --VAE_checkpoint_location ${VAE_checkpoint_location} \
        --model_name_suffix ${model_name_suffix} \
        --model_parameters_location ${model_parameters_location} \
        --training_logs_location ${training_logs_location} 
