#!/bin/bash
#FLUX: --job-name=spicy-lizard-6856
#FLUX: --urgency=16

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
           PYTHONPATH=$PWD python optimizers/darts/train_search.py --seed=${seed} --save=baseline_trans --search_space=1 --epochs=50 --weight_decay=0.00017949567554327632 --cutout --cutout_prob=0.576809112569184 --learning_rate=0.0011765562944021056
           exit $?
        fi
        let gpu_counter+=1
done
echo "DONE";
echo "Finished at $(date)";
