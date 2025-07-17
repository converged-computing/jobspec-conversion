#!/bin/bash
#FLUX: --job-name=lr
#FLUX: --queue=IllinoisComputes-GPU
#FLUX: -t=14400
#FLUX: --urgency=16

module load anaconda/2023-Mar/3
module load cuda/11.7
sleep $(($SLURM_ARRAY_TASK_ID * 30))
source activate py310
config=config2.txt
data_seed_start=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $2}' $config)
data_seed_end=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $3}' $config)
sgd_seed_start=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $4}' $config)
sgd_seed_end=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $5}' $config)
init_seed_start=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $6}' $config)
init_seed_end=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $7}' $config)
wd=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $8}' $config)
grok=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $9}' $config)
train_size=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $10}' $config)
hl_size=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $11}' $config)
lr_input=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $12}' $config)
srun python3  ../Ising_seed_cluster.py ${SLURM_ARRAY_TASK_ID} ${data_seed_start} ${data_seed_end} ${sgd_seed_start} ${sgd_seed_end} ${init_seed_start} ${init_seed_end} ${wd} ${grok} ${train_size} ${hl_size} ${lr_input}
echo "This is array task ${SLURM_ARRAY_TASK_ID}, ${data_seed_start} ${data_seed_end} ${sgd_seed_start} ${sgd_seed_end} ${init_seed_start} ${init_seed_end} ${wd} ${grok} ${train_size}" "${hl_size}" "${lr_input}" >> output.txt
