#!/bin/bash
#FLUX: --job-name=delicious-carrot-9664
#FLUX: --urgency=16

project=naturalsound-iEEG-sanitized-mixtures
non_list=(modulus real rect)
modulation_list=(spectempmod specmod tempmod)
length_modulation_list=${#modulation_list[@]}
length_non_list=${#non_list[@]}
if [ $SLURM_ARRAY_TASK_ID -lt $((length_modulation_list * length_non_list)) ]; then
    modulation_index=$(( SLURM_ARRAY_TASK_ID % length_modulation_list))
    non_list_index=$(( SLURM_ARRAY_TASK_ID / length_modulation_list))
    modulation_type=${modulation_list[modulation_index]}
    non_lin=${non_list[non_list_index]}
    model=cochleagram_spectrotemporal
    python -u /scratch/snormanh_lab/shared/code/snormanh_lab_python/feature_extraction/code/main.py "env=$project" "env.feature=$model" "env.spectrotemporal.modulation_type=$modulation_type" "env.spectrotemporal.nonlin=$non_lin" "env.device=cpu" "$@"
else
    index=$((SLURM_ARRAY_TASK_ID - length_modulation_list * length_non_list))
    model_list=("ast" "cochdnn" "cochresnet" "hubert" "spectrogram")
    model=${model_list[$index]}
    python -u /scratch/snormanh_lab/shared/code/snormanh_lab_python/feature_extraction/code/main.py "env=$project" "env.feature=$model" "$@"
fi
