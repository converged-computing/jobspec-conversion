#!/bin/bash
#FLUX: --job-name=bumfuzzled-hobbit-8286
#FLUX: --urgency=16

echo "Workingdir: $PWD";
echo "Started at $(date)";
echo "Running job $SLURM_JOB_NAME using $SLURM_JOB_CPUS_PER_NODE cpus per node with given JID $SLURM_JOB_ID on queue $SLURM_JOB_PARTITION";
source ~/.bashrc
conda activate pytorch1.3
gpu_counter=1
for epoch in 5 15 25 35 45
    do
        # Job to perform
        if [ $gpu_counter -eq $SLURM_ARRAY_TASK_ID ]; then
           PYTHONPATH=$PWD python nasbench_analysis/evaluate_one_shot_models.py --epoch=${epoch} --model_path=/home/siemsj/projects/darts_weight_sharing_analysis/experiments/random_ws/ss_20191019-025022_3_1
           exit $?
        fi
        let gpu_counter+=1
done
echo "DONE";
echo "Finished at $(date)";
