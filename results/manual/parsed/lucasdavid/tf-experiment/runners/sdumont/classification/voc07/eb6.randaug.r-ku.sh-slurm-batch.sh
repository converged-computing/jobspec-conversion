#!/bin/bash
#SBATCH --job-name=pbn_train_voc07
#SBATCH --output=/scratch/lerdl/lucas.david/logs/voc07/eb6-randaug/%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --partition=nvidia_long
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=1

echo "[train.voc07.sh] started running at $(date +'%Y-%m-%d %H:%M:%S')."
nodeset -e $SLURM_JOB_NODELIST
module load gcc/7.4 python/3.9.1 cudnn/8.2_cuda-11.1
CODE_DIR=$SCRATCH/experiments
BUILD_DIR=$SCRATCH/experiments/build
CONFIG_DIR=$SCRATCH/experiments/config/classification/voc07/eb6.randaug.yml
LOGS_DIR=$SCRATCH/logs/voc07/eb6-randaug/
cd $CODE_DIR
python3.9 -X pycache_prefix=$BUILD_DIR src/baseline.py with $CONFIG_DIR \
  model.head.layer_class=kernel_usage \
  model.head.dropout_rate=0 \
  setup.paths.ckpt=./logs/voc07/eb0-randaug-kur/backup/ \
  -F $LOGS_DIR
