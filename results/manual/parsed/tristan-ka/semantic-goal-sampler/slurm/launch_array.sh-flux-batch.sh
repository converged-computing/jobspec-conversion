#!/bin/bash
#FLUX: --job-name=sgs-array
#FLUX: -c=40
#FLUX: -t=1800
#FLUX: --urgency=16

filename=$1
extract_config(){
  file=$1
  index=$2
  i=0
  while read line; do
    if [ "$i" -eq "$index" ]; then
      output=$line;
    fi
    i=$((i+1))
  done < $file
}
extract_config $filename $(SLRUM_ARRAY_TASK_ID) \
module purge
module load pytorch-gpu/py3/1.9.0
conda activate sgs
chmod +x slurm/launcher.sh
srun slurm/launcher.sh \
  rl_script_args.path=$WORK/semantic-goal-sampler/src/main.py \
  $output \
  --config-path=$WORK/semantic-goal-sampler/conf \
  --config-name=slurm_cluster_config
