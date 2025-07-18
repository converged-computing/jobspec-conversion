#!/bin/bash
#FLUX: --job-name=${job_name}_${i}
#FLUX: -c=16
#FLUX: -t=15000
#FLUX: --urgency=16

export SINGULARITYENV_LD_LIBRARY_PATH='\$LD_LIBRARY_PATH'
export SINGULARITY_BINDPATH='/home/sbnb'

total_jobs=39
jobs_per_array=39
job_names=(
    "a1.signaturizer"
    "b4.signaturizer"
    "b4.signaturizer3d"
    "ecfp4.useChirality"
    "ecfp4"
    "mapc"
    "unimol"
)
start_value=0
for job_name in "${job_names[@]}"; do
    # Calculate the number of arrays required for the current job
    num_arrays=$(( (total_jobs + jobs_per_array - 1) / jobs_per_array ))
    # Initialize the start index
    start_index=0
    # Previous job ID (initialize as an empty string)
    previous_job_id=""
    # Submit the job arrays in chunks
    for ((i=0; i<num_arrays; i++)); do
        # Calculate the end index for this chunk
        end_index=$((start_index + jobs_per_array - 1))
        if [ $end_index -ge $total_jobs ]; then
            end_index=$((total_jobs - 1))
        fi
        # Create the VALUES array for this chunk
        values=($(seq $start_value $((start_value + (end_index - start_index)))))
        # Create the SLURM script for this chunk
        slurm_script=$(cat <<EOF
ml load Singularity
export SINGULARITYENV_LD_LIBRARY_PATH=\$LD_LIBRARY_PATH
export SINGULARITY_BINDPATH="/home/sbnb"
VALUES=(${values[@]})
THISJOBVALUE=\${VALUES[\$SLURM_ARRAY_TASK_ID]}
/apps/easybuild/common/software/Singularity/3.11.3/bin/singularity exec /home/sbnb/ddalton/projects/siganturizer_models/xgboost-env.sif python predict.py ${job_name} top \$THISJOBVALUE
EOF
        )
        # Submit the job array
        if [ -z "$previous_job_id" ]; then
            # Submit without dependency
            job_id=$(echo "$slurm_script" | sbatch)
        else
            # Submit with dependency on the previous job array
            job_id=$(echo "$slurm_script" | sbatch --dependency=afterok:$previous_job_id)
        fi
        # Extract the job ID
        job_id=$(echo $job_id | awk '{print $NF}')
        previous_job_id=$job_id
        # Update the start index and start value for the next chunk
        start_index=$((end_index + 1))
        start_value=$((start_value + jobs_per_array))
    done
    # Reset start_value for the next job name
    start_value=0
done
