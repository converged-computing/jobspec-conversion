#!/bin/bash
#SBATCH --output=/scratch/user/OUTPUTS/logs/%A.out
#SBATCH --error=/scratch/user/OUTPUTS/logs/%A.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=v100_full_node
#SBATCH --array=0-1%1

MASTER=`/bin/hostname -s`
MPORT=$(shuf -i 6000-9999 -n 1)
echo "Master: $MASTER"
echo "Port: $MPORT"
jobdir="$(dirname "$(dirname "$(pwd)")")";
CONFIG=$1
DATASET=$2
WEIGHT=$3
WEIGHT_PATH=${WEIGHT}
SEED=${4:-42}
cd $jobdir;
python eval_finetune_ood_charadesego.py \
            --dist-url tcp://${MASTER}:${MPORT} \
            --dist-backend 'nccl' \
            --multiprocessing-distributed \
            --world-size 1 --rank 0 \
            --quiet --sub_dir 'finetune' \
            --db ${DATASET} \
            --config-file ${CONFIG} \
            --weight_path ${WEIGHT_PATH} \
            --seed $SEED 
