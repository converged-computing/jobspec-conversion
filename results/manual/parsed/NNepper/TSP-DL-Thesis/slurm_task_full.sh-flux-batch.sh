#!/bin/bash
#FLUX: --job-name=FULL
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=36000
#FLUX: --urgency=16

module load Python/3.8.6-GCCcore-10.2.0
module load root_numpy/4.8.0-foss-2020b-Python-3.8.6
module load PyTorch/1.10.0-fosscuda-2020b
module load matplotlib/3.3.3-foss-2020b
module load SciPy-bundle/2020.11-fosscuda-2020b
module load scikit-learn/0.23.2-fosscuda-2020b
mkdir -p "$GLOBALSCRATCH/$LSLURM_JOB_ID"
mkdir -p "$HOME/$SLURM_JOB_ID"
python $HOME/TSP-DeepRL-Thesis/train.py --enc_num_heads 8  --num_nodes 20  --loss full --directory $GLOBALSCRATCH/$SLURM_JOB_ID --data_train  $GLOBALSCRATCH/data/tsp20_train.txt --data_test $GLOBALSCRATCH/data/tsp20_test.txt --n_gpu 1 --batch_size 512 --epochs 50 --teacher_forcing 0.5
