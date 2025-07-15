#!/bin/bash
#FLUX: --job-name=conversion
#FLUX: -t=1200
#FLUX: --priority=16

echo "Job Parameters:"
echo "CONFIG_PATH: $CONFIG_PATH"
echo "DATA_PATH: $DATA_PATH"
echo "CONVERSION_PATH: $CONVERSION_PATH"
echo "CONVERTER_IMAGE: $CONVERTER_IMAGE"
echo "Loading Singularity/Apptainer..."
module load singularity || true
file_to_convert=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID { $1=""; print substr($0,2) }' $CONFIG_PATH)
echo "Processing task $SLURM_ARRAY_TASK_ID: $file_to_convert"
if [ -e "$file_to_convert" ]; then
    # Log the conversion process
    echo "Starting conversion for task $SLURM_ARRAY_TASK_ID..."
    # Run the conversion with default parameters
    singularity run $CONVERSION_PATH/$CONVERTER_IMAGE "$file_to_convert"
    # Remove the original file/folder after conversion
    rm -rf "$file_to_convert"
    # Log the completion of the task
    echo "Task $SLURM_ARRAY_TASK_ID completed successfully."
else
    # Log if no corresponding input file is found
    echo "No corresponding input file for task $SLURM_ARRAY_TASK_ID."
fi
