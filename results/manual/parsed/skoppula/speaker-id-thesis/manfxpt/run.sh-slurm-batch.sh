#!/bin/bash
#SBATCH --job-name=bit32linear
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --time=02:00:00
#SBATCH --partition=cpu
#SBATCH --array=1-4

echo "$(hostname) $CUDA_VISIBLE_DEVICES"
echo "SLURM_JOBID="$SLURM_JOBID 
echo "SLURM_TASKID="$SLURM_ARRAY_TASK_ID
source /data/sls/r/u/skanda/home/envs/tf2cpu/bin/activate
cd /data/sls/r/u/skanda/home/thesis/manfxpt
MODELS=(buffer maxout1 maxout2 dsc1 dsc2)
whole_bitwidth=32
w_bits=$whole_bitwidth
a_bits=$whole_bitwidth
bias_bits=$whole_bitwidth
bn_bits=$whole_bitwidth
reg=False
load_ckpt="/data/sls/u/meng/skanda/home/thesis/manfxpt/models/sentfiltNone_${MODELS[$SLURM_ARRAY_TASK_ID]}_bnTrue_reg${reg}_noLRSchedule/checkpoint"
srun --cpus-per-task=4 --time=2:00:00 --partition=cpu python basicquant.py --model=${MODELS[$SLURM_ARRAY_TASK_ID]} --reg=$reg --load_ckpt=$load_ckpt --a_bits=$a_bits --w_bits=$w_bits --bn_bits=$bn_bits --bias_bits=$bias_bits &
wait
