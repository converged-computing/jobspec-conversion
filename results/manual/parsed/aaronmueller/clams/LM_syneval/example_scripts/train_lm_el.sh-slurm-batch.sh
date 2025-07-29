#!/bin/bash
#FLUX: --job-name=train_lm_el.$SLURM_JOBID
#FLUX: -c=6
#FLUX: --queue=gpuk80
#FLUX: -t=172799
#FLUX: --urgency=16

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
