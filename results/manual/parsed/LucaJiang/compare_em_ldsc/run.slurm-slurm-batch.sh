#!/bin/bash
#FLUX: --job-name=UKBHeight_unnamed
#FLUX: -c=16
#FLUX: --queue=special_bios
#FLUX: -t=43200
#FLUX: --urgency=16

N_SNP=40000 # Set the number of SNPs
N_SAMPLE=2000 # Set the number of samples
repeat_times=10 # Set repeat times of generate data
h_list=($(seq 0.1 0.1 0.9)) # Set heritability list
r_list=(1e-3 1e-2 5e-1) # Set Causal rate list
s_list=(0.1 1 10) # Set sigma_beta
data_path_name=/home/wjiang49/scratch/height_ukb_50k_chr22
output_path=/home/wjiang49/scratch/UKBsimdata
code_path=/home/wjiang49/UKBheight
log_path=/home/wjiang49/scratch/UKBsimdata/log
r_env="r4"
python_env="nsf"
if [ -n "$SLURM_ARRAY_TASK_ID" ]
then
    h_per_task=$(((${#h_list[@]} + $SLURM_ARRAY_TASK_MAX - 1) / $SLURM_ARRAY_TASK_MAX ))
    start_index=$((($SLURM_ARRAY_TASK_ID - 1) * $h_per_task))
    end_index=$(($start_index + $h_per_task - 1))
    # Ensure end_index is not greater than the length of h_list
    if [ $end_index -ge ${#h_list[@]} ]
    then
        end_index=$((${#h_list[@]} - 1))
    fi
    h_list=("${h_list[@]:$start_index:$((end_index - start_index + 1))}")
fi
sleep $((RANDOM % 10))
echo "$SLURM_JOB_NAME: Start time: $(date), Running h = ${h_list[*]}."
if [ ! -d $output_path ]; then
    mkdir -p $output_path
fi
if [ ! -d $log_path ]; then
    mkdir -p $log_path
fi
echo "Finish all the jobs at $(date)."
