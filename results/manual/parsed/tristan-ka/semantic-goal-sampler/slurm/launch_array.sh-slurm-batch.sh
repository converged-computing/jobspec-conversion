#!/bin/bash
#SBATCH --job-name=sgs-array
#SBATCH --account=imi@v100
#SBATCH --output=slurm_logs/%x-%j.out
#SBATCH --error=slurm_logs/%x-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --gres=gpu:4
#SBATCH --time=00:30:00
#SBATCH --qos=qos_gpu-dev
#SBATCH --constraint=ntasks-per-node=1,v100-32g
#SBATCH --array=1-4

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
