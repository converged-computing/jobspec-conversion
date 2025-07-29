#!/bin/bash
#SBATCH --job-name=s3p-sid
#SBATCH --output=./log_%j.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=30000
#SBATCH --partition=gpu
#SBATCH --exclude=sls-titan-[0-2]

export TORCH_HOME='.'

set -x
. /data/sls/scratch/share-201907/slstoolchainrc
source /data/sls/scratch/yuangong/ssast/venvssast/bin/activate
export TORCH_HOME=.
mkdir exp
mdl=ssast_frame_base_10s
lr=1e-4
expname=sid_${mdl}_${lr}
expdir=./exp/$expname
mkdir -p $expdir
python3 run_downstream.py --expdir $expdir -m train -u $mdl -d voxceleb1 -c config_sid.yaml -s hidden_states -o config.optimizer.lr=${lr} -f
