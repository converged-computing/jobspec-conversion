#!/bin/bash
#SBATCH --job-name=DARTS_NASBENCH
#SBATCH --output=log/log_$USER_%Y-%m-%d.out
#SBATCH --error=log/err_$USER_%Y-%m-%d.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --mem=10000
#SBATCH --time=11-00:00:00
#SBATCH --partition=gpu_tesla-P100
#SBATCH --chdir=/home/siemsj/projects/darts_weight_sharing_analysis
#SBATCH --array=1-12

echo "Workingdir: $PWD";
echo "Started at $(date)";
echo "Running job $SLURM_JOB_NAME using $SLURM_JOB_CPUS_PER_NODE cpus per node with given JID $SLURM_JOB_ID on queue $SLURM_JOB_PARTITION";
source ~/.bashrc
conda activate pytorch1.3
gpu_counter=1
for seed in {1..12}
    do
        # Job to perform
        if [ $gpu_counter -eq $SLURM_ARRAY_TASK_ID ]; then
           PYTHONPATH=$PWD python optimizers/darts/train_search.py --seed=${seed} --save=cutout --search_space=1 --cutout --epochs=25
           exit $?
        fi
        let gpu_counter+=1
done
echo "DONE";
echo "Finished at $(date)";
