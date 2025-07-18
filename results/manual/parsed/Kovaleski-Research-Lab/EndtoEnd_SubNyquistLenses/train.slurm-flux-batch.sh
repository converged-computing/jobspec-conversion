#!/bin/bash
#FLUX: --job-name=coop_training
#FLUX: --queue=gpu32,gpu40,gpu80
#FLUX: --urgency=16

distances=($(seq 0.01 0.0009 0.1))
enroot start --rw \
    -m /cgi/data/erdc_xai:/develop/data \
    -m /cgi/data/erdc_xai/resolution_constrained_deep_optics/results:/develop/results \
    -m /cgi/home/lindsaymb/workspace/documents/code:/develop/code \
    -m /cgi/data/erdc_xai/pretrained_models:/develop/pretrained_models \
    -m /cgi/data/erdc_xai/models:/develop/models \
    rcdo \
    python3 /develop/code/rcdo/experiment.py -config /develop/code/rcdo/config.yaml -job_id $SLURM_JOB_ID -distance ${distances[${SLURM_ARRAY_TASK_ID}]} -model_id coop_lrnxfer_randomInit_${distances[${SLURM_ARRAY_TASK_ID}]}
    #python3 /develop/code/rcdo/experiment.py -config /develop/code/rcdo/config.yaml -job_id $SLURM_JOB_ID -distance ${distances[0]} -model_id baseline_${distances[0]}
