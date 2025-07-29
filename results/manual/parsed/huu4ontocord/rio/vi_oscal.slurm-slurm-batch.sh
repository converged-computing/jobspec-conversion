#!/bin/bash
#SBATCH --job-name=vi_oscar_all
#SBATCH --account=six@gpu
#SBATCH --output=vi_oscar_all_%x-%j.stdout
#SBATCH --error=vi_oscar_all_%x-%j.stderr
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:4
#SBATCH --time=20:00:00
#SBATCH --constraint=ntasks-per-node=1

export HF_DATASETS_OFFLINE='1'
export TRANSFORMERS_OFFLINE='1'

set -x -e
export HF_DATASETS_OFFLINE=1
export TRANSFORMERS_OFFLINE=1
module load pytorch-gpu/py3/1.7.0
srun bash -c "time python process.py -hfdataset TurkuNLP/register_oscar,vi -src_lang vi -do_trans 0 -outfile=vi_oscar_all  -do_hf_ner 1 -do_spacy 1 -do_regex 1 -do_kenlm 1 -do_anonymization 1 -num_workers 4"
