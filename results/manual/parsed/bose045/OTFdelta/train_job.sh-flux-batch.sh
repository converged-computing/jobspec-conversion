#!/bin/bash
#FLUX: --job-name=dinosaur-taco-3236
#FLUX: --urgency=16

export OMP_NUM_THREADS='40 # Hyperthreading'
export PYTORCH_CUDA_ALLOC_CONF='max_split_size_mb:1280'

module load gcc/8.4.0/1 cuda/10.2 cuda/11.1
module spider openmpi/4.0.3/1
conda activate mace_env
export OMP_NUM_THREADS=40 # Hyperthreading
iter=print("%04d" % $1)
id=$SLURM_ARRAY_TASK_ID
cd ${iter}/MaceTrainPotential/seed${id}
export PYTORCH_CUDA_ALLOC_CONF=max_split_size_mb:1280
echo "usage sbatch train.job <seed int>"
echo "STARTING"
python /gpfs/u/home/XXXX/XXXXxxxx/scratch-shared/MACE/maceDevelop/mace/cli/run_train.py \
    --name="MACE_model" \
    --train_file="../../../AllSys.xyz" \
    --valid_fraction=0.05 \
    --config_type_weights='{"Default":1.0}' \
    --E0s="average" \
    --model="MACE" \
    --hidden_irreps='128x0e + 128x1o' \
    --r_max=5.0 \
    --batch_size=10 \
    --max_num_epochs=30 \
    --swa \
    --start_swa=1200 \
    --ema \
    --ema_decay=0.99 \
    --amsgrad \
    --device=cuda \
    --seed=${1} \
    --restart_latest \
echo 'DONE RUNNING!!'
