#!/bin/bash
#FLUX: --job-name=rerun_metrics
#FLUX: -c=10
#FLUX: -t=72000
#FLUX: --urgency=16

module purge
module load tensorflow-gpu/py3/2.4.1
set -x
srun python -u $WORK/repo/wf-psf/debug/jz_helper_eval_plot_script.py 
