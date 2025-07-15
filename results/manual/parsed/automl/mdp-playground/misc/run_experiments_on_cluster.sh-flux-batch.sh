#!/bin/bash
#FLUX: --job-name=dinosaur-earthworm-4061
#FLUX: --priority=16

export EXP_NAME='dqn_seq_del' # Ideally contains Area of research + algorithm + dataset # Could just pass this as job name?'

export EXP_NAME='dqn_seq_del' # Ideally contains Area of research + algorithm + dataset # Could just pass this as job name?
echo -e '\033[32m'
echo "Workingdir: $PWD";
echo "Started at $(date)";
echo "Running job $SLURM_JOB_NAME using $SLURM_JOB_CPUS_PER_NODE cpus per node with Job ID: $SLURM_JOB_ID on queue $SLURM_JOB_PARTITION";
echo "SLURM_CONF location: ${SLURM_CONF}"
echo "SLURM_JOB_NODELIST = ${SLURM_JOB_NODELIST}"
/bin/hostname -f
python3 -V
echo Paths: $PATH
echo Parent program $0
echo Shell used is $SHELL
. /home/rajanr/anaconda3/etc/profile.d/conda.sh # for anaconda3
conda activate /home/rajanr/anaconda3/envs/old_py36_toy_rl # should be conda activate and not source when using anaconda3?
which python
python -V
which python3
python3 -V
ping google.com -c 3
echo -e '\033[0m'
echo -e "Script file start:\n====================="
cat $0
echo -e "\n======================\nScript file end!"
echo "Line common to all tasks with SLURM_JOB_ID: ${SLURM_JOB_ID}, SLURM_ARRAY_JOB_ID: ${SLURM_ARRAY_JOB_ID}, SLURM_ARRAY_TASK_ID: ${SLURM_ARRAY_TASK_ID}"
mkdir -p mdpp_${SLURM_ARRAY_JOB_ID}
cd mdpp_${SLURM_ARRAY_JOB_ID}
\time -v python3 /home/rajanr/mdp-playground/run_experiments.py --exp-name ${EXP_NAME} --config-file /home/rajanr/mdp-playground/experiments/${EXP_NAME} --config-num ${SLURM_ARRAY_TASK_ID}
echo "The SLURM_ARRAY_JOB_ID is: ${SLURM_ARRAY_JOB_ID}"
echo "DONE";
echo "Finished at $(date)";
