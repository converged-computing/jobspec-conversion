#!/bin/bash
#FLUX: --job-name=phat-omelette-5588
#FLUX: -N=32
#FLUX: -n=32
#FLUX: -c=12
#FLUX: --queue=normal
#FLUX: -t=3600
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export MASTER_ADDR='$(srun --ntasks=1 hostname 2>&1 | tail -n1)'

module load daint-gpu
module load cudatoolkit/10.2.89_3.28-2.1__g52c0314
conda activate py38_oktopk
which nvcc
nvidia-smi
which python
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export MASTER_ADDR=$(srun --ntasks=1 hostname 2>&1 | tail -n1)
echo $MASTER_ADDR
srun python -m mpi4py main_bert.py \
        --module models.bert12.depth=4 \
        --max_seq_length 128 \
        --train_batch_size 8 \
        --train_path ./bert_data/wikipedia.segmented.nltk.txt \
        --bert_config_path configs/bert_config_bert-base-uncased.json \
        --vocab_path ./bert_data/bert-large-uncased-vocab.txt \
        --checkpoint_dir ./checkpoints_oktopk \
        --do_train \
        --do_lower_case \
        --num_minibatches 1024 \
	--density 0.01 \
	--compressor 'oktopk' \
        --gradient_accumulation_steps 1 --dataparallel --config_path tests/depth=4/conf_32nodes.json
