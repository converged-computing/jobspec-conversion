#!/bin/bash
#SBATCH --job-name=intcqa_bert_quick
#SBATCH --output=/user/work/es1595/intercqabert.out.%j
#SBATCH --error=/user/work/es1595/intercqabert.err.%j
#SBATCH --mail-user=edwin.simpson@bristol.ac.uk
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=128G
#SBATCH --time=3-00:00:00
#SBATCH --exclusive

export OMP_NUM_THREADS='24'

module load lang/python/anaconda/pytorch
cd /user/home/es1595/tacl2020-interactive-ranking
export OMP_NUM_THREADS=24
python -u stage1_coala.py GPPLHH 0 cqa_bert_imp_gpplhh_4 "[imp]" . 4 4 BERT
