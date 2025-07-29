#!/bin/bash
#SBATCH --job-name=r2c_eval
#SBATCH --output=/checkpoint/%u/logs/r2c-eval-%j.out
#SBATCH --error=/checkpoint/%u/logs/r2c-eval-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --gres=gpu:8
#SBATCH --mem=200G
#SBATCH --time=02:00:00
#SBATCH --constraint=ntasks-per-node=1

export PYTHONPATH='$PYTHONPATH":"$BASEDIR'
export PYTHONUNBUFFERED='True'

. /usr/share/modules/init/sh
source deactivate
module purge
module load cuda/9.0
module load NCCL/2.2.12-1-cuda.9.0
module load cudnn/v7.0-cuda.9.0
module load anaconda3/5.0.1
module load FAISS/010818/gcc.5.4.0/anaconda3.5.0.1
source activate /private/home/"$USER"/.conda/envs/vcr
PARAM_FILE=${1:-"default"}
SPLIT=${2:-"val"}
ANSWER_MODEL=$3  # ${3:-"/checkpoint/viswanath/r2c/models/baseline_answer/best.th"}
RATIONALE_MODEL=$4  # ${4:-"/checkpoint/viswanath/r2c/models/baseline_rationale/best.th"}
AR_MODEL=$5  #  ${5:-"/checkpoint/viswanath/r2c/models/joint_model/best.th"}
BASEDIR=$PWD
SOURCE="$BASEDIR"/scripts/run_eval.py
PARAMS="$BASEDIR"/models/multiatt/"$PARAM_FILE".json
echo "Running job $SLURM_JOB_ID on $SLURMD_NODENAME"
export PYTHONPATH="$PYTHONPATH":"$BASEDIR"
export PYTHONUNBUFFERED=True
ARGS=""
if [ ! -z "$ANSWER_MODEL" ]; then
  ARGS="$ARGS --answer_model $ANSWER_MODEL"
fi
if [ ! -z "$RATIONALE_MODEL" ]; then
  ARGS="$ARGS --rationale_model $RATIONALE_MODEL"
fi
if [ ! -z "$AR_MODEL" ]; then
  ARGS="$ARGS --ar_model $AR_MODEL"
fi
OUTFILE="/checkpoint/$USER/logs/leaderboard_$SLURM_JOB_ID.csv"
echo "Leaderboard output will be written to $OUTFILE"
srun --label \
  python $SOURCE \
  --params $PARAMS \
  --split $SPLIT \
  --outfile $OUTFILE \
  $ARGS
