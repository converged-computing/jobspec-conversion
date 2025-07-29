#!/bin/bash
#SBATCH --job-name=llm_hm_without_low_score
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=50GB
#SBATCH --time=2-23:05:00
#SBATCH --partition=gpu

export GLOG_minloglevel='2'
export MAGNUM_LOG='quiet'

export GLOG_minloglevel=2
export MAGNUM_LOG="quiet"
MASTER_ADDR=$(srun --ntasks=1 hostname 2>&1 | tail -n1)
export MASTER_ADDR
mkdir $TMPDIR/myArchive
tar xvzf /scratch/%USER/Objectnav/hm3d.tar.gz $TMPDIR/myArchive
module load PyTorch/1.12.1-foss-2022a-CUDA-11.7.0
source $HOME/.envs/habitat21/bin/activate
set -x
srun python main_llm_vis.py --split val --eval 1 --auto_gpu_config 0 \
-n 8 --num_eval_episodes 250 --num_processes_on_first_gpu 8 \
--load pretrained_models/llm_model.pt  --use_gtsem 0 \
--num_local_steps 10 --exp_name exp_llm_without_low_score
cp -r outputdata /scratch/$USER/mydataset/
