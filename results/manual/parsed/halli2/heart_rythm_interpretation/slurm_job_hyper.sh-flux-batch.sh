#!/bin/bash
#FLUX: --job-name=cardiac_hyper_fit
#FLUX: --queue=gpuA100
#FLUX: -t=86400
#FLUX: --urgency=16

uenv verbose cuda-11.8.0 cudnn-11.x-8.6.0
uenv verbose TensorRT-11.x-8.6-8.5.3.1
uenv verbose miniconda3-py310
conda activate tf_env
python -u src/cardiac_rythm/hyper_tune.py \
"/home/prosjekt/BMDLab/matlab/resprog/GUI/CleanCutsDL/cutDataCinCTTI_rev_v2.mat"  \
--max_trials 250 \
--n_folds 10 \
--n_filters 2 \
--filters 5 10 15 20 25 30 40 50 \
--kernels 5 10 15 20 25 30 40 50 \
--dropout 0.1 0.9 \
--pool 2 \
--stride 1 \
--n_fc 2 \
--fc_choice 16 32 64 128
echo "--Finished--"
