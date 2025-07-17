#!/bin/bash
#FLUX: --job-name=pt-array
#FLUX: --queue=dept_gpu
#FLUX: -t=2419200
#FLUX: --urgency=16

eval "$(conda shell.bash hook)"
conda activate pytorch_c6m12_cuda101
module load cuda/10.1
echo $(which python)
echo "${SLURM_ARRAY_TASK_ID}"
cd $SLURM_SUBMIT_DIR
cmd="$(sed -n "${SLURM_ARRAY_TASK_ID}p" ../research/cluster/200127_pt_array.txt)"
echo $cmd
eval $cmd
exit 0
