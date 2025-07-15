#!/bin/bash
#FLUX: --job-name=lovable-parrot-5866
#FLUX: --queue=gputest
#FLUX: -t=900
#FLUX: --urgency=16

OUTPUT_DIR=output_dir
rm -rf "$OUTPUT_DIR"
rm -f logs/latest.out logs/latest.err
ln -s $SLURM_JOBID.out logs/latest.out
ln -s $SLURM_JOBID.err logs/latest.err
module purge
module load gcc/9.1.0 cuda/11.1.0 StdEnv git
cd $TMPDIR
python3 -m venv venv
source venv/bin/activate
python -m pip install --upgrade pip
python -m pip install --upgrade setuptools
python -m pip install --upgrade wheel
python -m pip install torch==1.8.0+cu111 -f https://download.pytorch.org/whl/torch_stable.html
python -m pip install git+https://github.com/huggingface/transformers
python -m pip install datasets
python -m pip install deepspeed
cd -
python run_clm.py \
    --tokenizer tokenizer \
    --model_type gpt2 \
    --train_file texts.txt \
    --do_train \
    --num_train_epochs 1 \
    --per_device_train_batch_size 4 \
    --output_dir "$OUTPUT_DIR"
