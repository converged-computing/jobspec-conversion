#!/bin/bash
#FLUX: --job-name=safe
#FLUX: -c=2
#FLUX: -t=72000
#FLUX: --urgency=16

cd ${SLURM_SUBMIT_DIR}
maindir=$WORK/Token_QuestEval
module purge
module load cmake/3.14.4
module load cuda/11.2 nccl/2.6.4-1-cuda cudnn/8.1.1.33-cuda
module load intel-mkl/2020.1
module load magma/2.5.4-cuda
module load gcc/10.1.0
module load openmpi/4.1.1-cuda
module load boost/1.74.0
eval "$(/gpfslocalsup/pub/anaconda-py3/2020.02/bin/conda shell.bash hook)"
conda activate py38
TRANSFORMERS_OFFLINE=1 HF_DATASETS_OFFLINE=1 \
		    python -u scripts/finetune_t5_mt.py data/paraphrase/parabank.threshold0.7.detok.masked-examples.jsonl.part-${SLURM_ARRAY_TASK_ID} \
		    --output_dir models/train_t5_paraphrase/ 2>> models/train_t5_paraphrase/train.log
