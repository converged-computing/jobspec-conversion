#!/bin/bash
#SBATCH --job-name=PERTTI_reg
#SBATCH --output=PERTTI_reg.out.%j
#SBATCH --error=PERTTI_reg.err.%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:k80:1
#SBATCH --mem=64000
#SBATCH --time=00:15:00

module purge
module load gcc cuda python-env/3.6.3-ml
SRCDIR=/homeappl/home/celikkan/Github/BERT-prosody
DATADIR=$SRCDIR/data
python  $SRCDIR/main.py --datadir $DATADIR --number_of_sents 100 --model Regression
