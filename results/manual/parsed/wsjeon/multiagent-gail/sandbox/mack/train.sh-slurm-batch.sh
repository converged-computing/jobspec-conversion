#!/bin/bash
#SBATCH --job-name=train
#SBATCH --account=rpp-bengioy
#SBATCH --output=/home/jeonwons/scratch/slurm_output/slurm-%a.out
#SBATCH --mail-user=jeonwons@mila.quebec
#SBATCH --mail-type=ARRAY_TASKS,ALL,TIME_LIMIT_50,TIME_LIMIT_80,TIME_LIMIT_90,TIME_LIMIT
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:1
#SBATCH --mem=10G
#SBATCH --time=20:00:00
#SBATCH --array=0-139

export LC_ALL='C.UTF-8'
export LANG='C.UTF-8'
export CONTAINER_NAME='wsjeon-marl-dev-setting-master-zsh.simg'
export PROJECT_DIR='PycharmProjects/multiagent-gail'

module load singularity
export LC_ALL=C.UTF-8
export LANG=C.UTF-8
echo $HOSTNAME
export CONTAINER_NAME=wsjeon-marl-dev-setting-master-zsh.simg
export PROJECT_DIR=PycharmProjects/multiagent-gail
singularity exec --nv \
        -H $HOME:/home \
        -B $SLURM_TMPDIR:/dataset/ \
        -B $SCRATCH:/tmp_log/ \
        -B $SCRATCH:/final_log/ \
        $SCRATCH/singularity-images/$CONTAINER_NAME \
        python -u $PROJECT_DIR/sandbox/mack/train_with_taskid.py --slurm_task_id=$SLURM_ARRAY_TASK_ID
