#!/bin/bash
#SBATCH --job-name=CrossQ
#SBATCH --output=/home/palenicek/projects/sbx-crossq/logs/%A_%a.out.log
#SBATCH --error=/home/palenicek/projects/sbx-crossq/logs/%A_%a.err.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=7000
#SBATCH --time=3-00:00:00
#SBATCH --partition=gpu
#SBATCH --constraint=rtx3090
#SBATCH --array=1-11

export GTIMER_DISABLE='1'

SCRIPT_PATH=$(dirname $(scontrol show job $SLURM_JOBID | awk -F= '/Command=/{print $2}'))
echo $SCRIPT_PATH
source $SCRIPT_PATH/conda_hook
echo "Base Conda: $(which conda)"
eval "$($(which conda) shell.bash hook)"
conda activate crossq
echo "Conda Env:  $(which conda)"
export GTIMER_DISABLE='1'
echo "GTIMER_DISABLE: $GTIMER_DISABLE"
cd $SCRIPT_PATH
echo "Working Directory:  $(pwd)"
python /home/palenicek/projects/sbx-crossq/train.py \
    -algo $ALGO \
    -env $ENV \
    -seed $SLURM_ARRAY_TASK_ID \
    -critic_activation $ACT \
    -lr $LR \
    -utd $UTD \
    -policy_delay $PI_DELAY \
    -adam_b1 $B1 \
    -crossq_style $XQ_STYLE \
    -bn $BN \
    -ln $LN \
    -n_critics $N_CRITICS \
    -n_neurons $N_NEURONS \
    -bn_mode $BN_MODE \
    -bn_momentum $BN_MOM \
    -total_timesteps $STEPS \
    -eval_qbias $EVAL_QBIAS \
    -wandb_mode 'online'
