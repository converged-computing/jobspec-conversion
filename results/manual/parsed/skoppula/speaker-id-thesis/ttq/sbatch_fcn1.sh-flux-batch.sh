#!/bin/bash
#FLUX: --job-name=fcn1_ttq
#FLUX: -c=5
#FLUX: -t=187200
#FLUX: --urgency=16

echo "$(hostname) $CUDA_VISIBLE_DEVICES"
echo "SLURM_JOBID="$SLURM_JOBID 
echo "SLURM_TASKID="$SLURM_ARRAY_TASK_ID
source /data/sls/r/u/skanda/home/envs/tf2gpu/bin/activate
cd /data/sls/u/meng/skanda/home/thesis/ttq
model=fcn1
quant_ends=(buffer True False)
end=${quant_ends[$SLURM_ARRAY_TASK_ID]}
loadckpt="../dorefa/real/train_log/${model}_w_4_a_32_quant_ends_${end}"
loadckpt="${loadckpt}_preload"
loadckpt="${loadckpt}/checkpoint"
echo $loadckpt
srun --cpus-per-task=4 --gres=gpu:1 --time=48:00:00 python ttq_run.py --model_name=$model --quant_ends=${end} --load_ckpt=$loadckpt &
wait
