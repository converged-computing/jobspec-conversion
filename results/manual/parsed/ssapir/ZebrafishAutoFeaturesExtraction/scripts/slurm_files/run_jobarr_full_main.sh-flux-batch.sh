#!/bin/bash
#FLUX: --job-name=angry-taco-5530
#FLUX: -t=43200
#FLUX: --urgency=16

dataset_path=$1
fish=$2
SIZE=$3
repository_relative_to_script_path=$4
opencv_conda_env=$5
fast_run=""
if [[ $# -ge 6 ]]; then
  if [[ "$6" == "--fast_run" ]] ; then
      fast_run="--fast_run"
  fi
fi
input_args=$@ # save if needed
shift $# # remove arguments - this is preventing bug in source usage below
args="--vid_type ".raw" --full --parallel --fish_only $fast_run"
STOP=$(( $((SLURM_ARRAY_TASK_ID + 1))*SIZE))
START="$(($STOP - $(($SIZE - 1))))"
args="$args --start $START --end $STOP"
if [ -n $SLURM_ARRAY_TASK_ID ];  then
    # check the original location through scontrol and $SLURM_JOB_ID
    SCRIPT_PATH=$(scontrol show job ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} | awk -F= '/Command=/{print $2}' | head -n1 | cut -f1 -d " ")
else
    # otherwise: started with bash. Get the real location.
    SCRIPT_PATH=$(realpath $0)
fi
echo "Array task id: $SLURM_ARRAY_TASK_ID, event num: $EVENT_NUM"
echo "Script path: $SCRIPT_PATH"
path=$(dirname $SCRIPT_PATH)
source ~/anaconda3/bin/activate
conda init
conda activate $opencv_conda_env
start_time=$(date)
echo "Start $start_time"
echo "Run fish $fish with args $args"
python $path/../$repository_relative_to_script_path/main.py $dataset_path $fish $args
end_time=$(date)
echo "Stop $end_time"
echo conda deactivate
