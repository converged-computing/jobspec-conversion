#!/bin/bash
#FLUX: --job-name=DARTS_NASBENCH
#FLUX: -c=2
#FLUX: --queue=bosch_gpu-rtx2080
#FLUX: -t=950400
#FLUX: --urgency=15

echo "Workingdir: $PWD";
echo "Started at $(date)";
echo "Running job $SLURM_JOB_NAME using $SLURM_JOB_CPUS_PER_NODE cpus per node with given JID $SLURM_JOB_ID on queue $SLURM_JOB_PARTITION";
source ~/.bashrc
conda activate pytorch1.3
gpu_counter=1
for wd in "1e-4" "9e-4" "27e-4" "81e-4"
    do
        # Job to perform
        if [ $gpu_counter -eq $SLURM_ARRAY_TASK_ID ]; then
           PYTHONPATH=$PWD python optimizers/gdas/train_search.py --seed=3 --save=weight_decay --weight_decay=${wd} --search_space=1
           exit $?
        fi
        let gpu_counter+=1
done
echo "DONE";
echo "Finished at $(date)";
