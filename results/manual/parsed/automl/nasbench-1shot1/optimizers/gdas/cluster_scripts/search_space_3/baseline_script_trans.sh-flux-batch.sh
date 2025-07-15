#!/bin/bash
#FLUX: --job-name=strawberry-destiny-2119
#FLUX: --priority=16

echo "Workingdir: $PWD";
echo "Started at $(date)";
echo "Running job $SLURM_JOB_NAME using $SLURM_JOB_CPUS_PER_NODE cpus per node with given JID $SLURM_JOB_ID on queue $SLURM_JOB_PARTITION";
source ~/.bashrc
conda activate pytorch1.3
gpu_counter=1
for seed in {1..6}
    do
        # Job to perform
        if [ $gpu_counter -eq $SLURM_ARRAY_TASK_ID ]; then
           PYTHONPATH=$PWD python optimizers/gdas/train_search.py --seed=${seed} --save=baseline_trans --search_space=3 --epochs=50 --weight_decay=1.0685329756580793e-05 --cutout --cutout_prob=0.3118341613188339 --learning_rate=0.854962095974854
           exit $?
        fi
        let gpu_counter+=1
done
echo "DONE";
echo "Finished at $(date)";
