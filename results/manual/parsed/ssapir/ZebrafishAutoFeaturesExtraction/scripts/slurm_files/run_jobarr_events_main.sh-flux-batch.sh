#!/bin/bash
#FLUX: --job-name=faux-motorcycle-3771
#FLUX: --priority=16

dataset_path=$1
fish=$2
repository_relative_to_script_path=$3
opencv_conda_env=$4
args=''
if [[ $# -ge 5 ]]; then
  if [[ "$5" == "--full" ]] ; then
     args='--full'
  elif [[ "$5" == "--control"  ]]; then
     args='--control_data'
  else
     echo "error: unknown 3rd argument $5" >&2; exit 1
  fi
fi
echo "Args: $args"
input_args=$@ # save if needed
shift $# # remove arguments - this is preventing bug in source usage below
EVENT_NUM=$(( $((SLURM_ARRAY_TASK_ID + 1)))) # counting starts from 1 in event numbers
if [ -n $SLURM_ARRAY_TASK_ID ];  then
    # check the original location through scontrol and $SLURM_JOB_ID
    SCRIPT_PATH=$(scontrol show job ${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} | awk -F= '/Command=/{print $2}' | head -n1 | cut -f1 -d " ")
else
    # otherwise: started with bash. Get the real location.
    SCRIPT_PATH=$(realpath $0)
fi
path=$(dirname $SCRIPT_PATH)
echo "Array task id: $SLURM_ARRAY_TASK_ID, event num: $EVENT_NUM"
echo "Script path: $SCRIPT_PATH"
source ~/anaconda3/bin/activate
conda init
conda activate $opencv_conda_env
start_time=$(date)
echo "Start $start_time"
m_args="--vid_type ".raw" --event_number $EVENT_NUM --parallel $args"
python $path/../../main.py $dataset_path $fish $m_args
end_time=$(date)
echo "Stop $end_time"
conda deactivate
