#!/bin/bash
#SBATCH --job-name=trainResNetUlm
#SBATCH --account=def-jeproa
#SBATCH --output=output_dir/ResNetUlm/%j-%x.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:1
#SBATCH --mem=32G
#SBATCH --time=23:59:00

cd ~/IFT-6164-ConditionalGenerationUS
module load python/3.9
virtualenv --no-download $SLURM_TMPDIR/env
source $SLURM_TMPDIR/env/bin/activate
pip install --no-index --upgrade pip
pip install --no-index -r requirementsCC.txt
cp -rv ~/scratch/data/data_CGenULM/patchesIQ_small_shuffled $SLURM_TMPDIR/
python trainResNetULM.py
