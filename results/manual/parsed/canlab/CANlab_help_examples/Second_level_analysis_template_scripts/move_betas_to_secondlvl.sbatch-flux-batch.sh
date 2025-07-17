#!/bin/bash
#FLUX: --job-name=movebetas_bodymap
#FLUX: --queue=standard
#FLUX: -t=86400
#FLUX: --urgency=16

output_log_dir="log/movebetas"
error_log_dir="log/movebetas"
mkdir -p "$output_log_dir"
mkdir -p "$error_log_dir"
hostname
shopt -s extglob
firstlvl_dir="/dartfs-hpc/rc/lab/C/CANlab/labdata/data/WASABI/derivatives/canlab_firstlvl"
data_dir="/dartfs-hpc/rc/lab/C/CANlab/labdata/projects/WASABI/WASABI_N_of_Few/analysis/WASABI-NofFew_BodyMap/data"
map_dirs=("$firstlvl_dir"/sub-*/ses-*/func/firstlvl/bodymap)
sub=$(basename "$(dirname "$(dirname "$(dirname "$(dirname "${map_dirs[SLURM_ARRAY_TASK_ID]}")")")")")
ses=$(basename "$(dirname "$(dirname "$(dirname "${map_dirs[SLURM_ARRAY_TASK_ID]}")")")")
task=$(basename "${map_dirs[SLURM_ARRAY_TASK_ID]}")
echo "sub: $sub, ses: $ses, task: $task"
echo "conditions: '${conditions_str}'"
module load matlab
srun matlab -nodisplay -r "move_betas_to_secondlvl('${map_dirs[${SLURM_ARRAY_TASK_ID}]}', '${data_dir}', 'symlink')"
