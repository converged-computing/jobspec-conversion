#!/bin/bash
#FLUX: --job-name=PC_DARTS_LR_NASBENCH
#FLUX: -c=2
#FLUX: --queue=bosch_gpu-rtx2080
#FLUX: -t=950400
#FLUX: --urgency=16

echo "Workingdir: $PWD";
echo "Started at $(date)";
echo "Running job $SLURM_JOB_NAME using $SLURM_JOB_CPUS_PER_NODE cpus per node with given JID $SLURM_JOB_ID on queue $SLURM_JOB_PARTITION";
source ~/.bashrc
conda activate pytorch1.3
gpu_counter=1
for lr in "0.25" "0.0025"
    do
        # Job to perform
        if [ $gpu_counter -eq $SLURM_ARRAY_TASK_ID ]; then
           PYTHONPATH=$PWD python optimizers/pc_darts/train_search.py --seed=12 --save=learning_rate --learning_rate=${lr} --search_space=3
           exit $?
        fi
        let gpu_counter+=1
done
echo "DONE";
echo "Finished at $(date)";
