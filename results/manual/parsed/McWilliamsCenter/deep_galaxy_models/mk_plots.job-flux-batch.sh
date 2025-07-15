#!/bin/bash
#FLUX: --job-name=deep_gal
#FLUX: -c=10
#FLUX: --queue=gpu_p2
#FLUX: -t=7200
#FLUX: --urgency=16

export PYTHONPATH='.'

module purge
module load anaconda-py3/2019.03 cuda/10.0 cudnn/7.6.5.32-cuda-10.1 fftw/3.3.8 r
set -x
cd $WORK/repo/deep_galaxy_models
export PYTHONPATH=.
python scripts/mk_plots.py --generative_model=modules/flow_vae_maf_16/generator \
                           --out_dir=results \
			   --n_batches=20
