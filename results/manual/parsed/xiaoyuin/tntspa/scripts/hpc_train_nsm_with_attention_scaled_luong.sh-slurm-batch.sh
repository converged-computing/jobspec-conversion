#!/bin/bash
#SBATCH --job-name=hpc_nsm_att_sluo
#SBATCH --account=p_adm
#SBATCH --output=train_nsm_attention_scaled_luong-%j.out
#SBATCH --mail-user=xiaoyu.yin@mailbox.tu-dresden.de
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=20000
#SBATCH --time=08:00:00

module load TensorFlow/1.8.0-foss-2018a-Python-3.6.4-CUDA-9.2.88
DDIR=data/monument_600
MDIR=output/models
if [ -n "$1" ]
    then DDIR=$1
fi
if [ -n "$2" ]
    then MDIR=$2
fi
srun python3 -m nmt.nmt.nmt \
    --src=en --tgt=sparql \
    --hparams_path=nmt_hparams/neural_sparql_machine_attention_scaled_luong.json \
    --out_dir=$MDIR/neural_sparql_machine_attention_scaled_luong \
    --vocab_prefix=$DDIR/vocab \
    --train_prefix=$DDIR/train \
    --dev_prefix=$DDIR/dev \
    --test_prefix=$DDIR/test
exit 0
