#!/bin/bash
#FLUX: --job-name=SSCL-unsup-bsz-512-tbsz-512-no-cosine-1000e
#FLUX: -c=16
#FLUX: -t=43140
#FLUX: --urgency=16

cd $SLURM_TMPDIR
cp -r ~/scratch/Semi-Supervised-CL .
cd Semi-Supervised-CL
rm -r save
module load python/3.7 cuda/10.0
virtualenv --no-download venv
source venv/bin/activate
pip install --no-index --upgrade pip
pip install --no-index -r requirements.txt
python main_semicl.py \
  --model resnet50 \
  --epochs 1000 \
  --batch_size 512 \
  --training_batch_size 512 \
  --learning_rate 0.5 \
  --temp 0.5 \
  --labeled_prob 0.0 \
  --unlabeled_prob 1.0 \
  --labeled_memory_capacity 0 \
  --unlabeled_memory_capacity 0
python main_linear.py \
  --model resnet50 \
  --epochs 100 \
  --batch_size 512 \
  --learning_rate 1 \
  --ckpt ./save/SupCon/*/*/last.pth
cp -r save/ ~/scratch/Semi-Supervised-CL/
