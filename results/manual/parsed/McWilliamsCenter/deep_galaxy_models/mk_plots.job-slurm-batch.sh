#!/bin/bash
#SBATCH --job-name=deep_gal
#SBATCH --output=dg%j.out
#SBATCH --error=dg%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:1
#SBATCH --time=02:00:00
#SBATCH --qos=qos_gpu-dev

export PYTHONPATH='.'

module purge
module load anaconda-py3/2019.03 cuda/10.0 cudnn/7.6.5.32-cuda-10.1 fftw/3.3.8 r
set -x
cd $WORK/repo/deep_galaxy_models
export PYTHONPATH=.
python scripts/mk_plots.py --generative_model=modules/flow_vae_maf_16/generator \
                           --out_dir=results \
			   --n_batches=20
