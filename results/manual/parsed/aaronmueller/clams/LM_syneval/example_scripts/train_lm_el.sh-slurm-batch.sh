#!/bin/bash
#SBATCH --job-name=train_lm_el.$SLURM_JOBID
#SBATCH --output=/home-1/amuelle8@jhu.edu/logs/out-lstm-el.$SLURM_JOBID.log
#SBATCH --error=/home-1/amuelle8@jhu.edu/logs/err-lstm-el.$SLURM_JOBID.log
#SBATCH --mail-user=amuelle8@jhu.edu
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:1
#SBATCH --time=1-23:59:59
#SBATCH --partition=gpuk80
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --chdir=/home-1/amuelle8@jhu.edu/scratch/workdir/el.$SLURM_JOBID

module load cuda/9.0
source /home-1/amuelle8@jhu.edu/miniconda3/bin/activate
PATH=/home-1/amuelle8@jhu.edu/miniconda3/bin:$PATH
LD_LIBRARY_PATH=/home-1/amuelle8@jhu.edu/miniconda3/lib:$LD_LIBRARY_PATH
conda activate for_pytorch
source /home-1/amuelle8@jhu.edu/scratch/LM_syneval/hyperparameters_el.txt
mkdir -p ${model_dir}.$SLURM_JOBID
python3 -u $lm_dir/main.py \
       --lm_data $lm_data_dir \
       --cuda \
       --epochs $epochs \
       --model $model \
       --nhid $num_hid \
       --save ${model_dir}.$SLURM_JOBID/lstm_lm.pt \
       --save_lm_data ${model_dir}.$SLURM_JOBID/lstm_lm.bin \
       --log-interval $log_freq \
       --batch $batch_size \
       --dropout $dropout \
	   --seed $SLURM_JOBID \
       --lr $lr \
       --trainfname $train \
       --validfname $valid \
       --testfname $test
