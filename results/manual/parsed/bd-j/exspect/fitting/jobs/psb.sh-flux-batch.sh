#!/bin/bash
#FLUX: --job-name=loopy-soup-7801
#FLUX: --priority=16

export GROUP='conroy_lab'
export MYSCRATCH='$SCRATCH/$GROUP/$USER'
export SPS_HOME='$SCRATCH/$GROUP/$USER/fsps'

module purge
module load gcc/9.2.0-fasrc01
module load Anaconda3/5.0.1-fasrc01
export GROUP=conroy_lab
export MYSCRATCH=$SCRATCH/$GROUP/$USER
export SPS_HOME=$SCRATCH/$GROUP/$USER/fsps
source activate prox
cd $MYSCRATCH/exspect/fitting
objnum=92942
data="--objname $objnum --zred=0.073"
model="--continuum_order=12 --add_neb --free_neb_met --marginalize_neb"
model=$model" --nbins_sfh=8 --jitter_model --mixture_model"
fit="--dynesty --nested_method=rwalk --nlive_batch=200 --nlive_init 500"
fit=$fit" --nested_dlogz_init=0.01 --nested_posterior_thresh=0.03"
mkdir -p output/psb_results
python psb_params.py $fit $model $data \
                     --outfile=output/psb_results/psb_$objnum
