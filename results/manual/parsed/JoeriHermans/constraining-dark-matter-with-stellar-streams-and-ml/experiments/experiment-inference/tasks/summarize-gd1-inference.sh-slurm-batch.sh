#!/bin/bash
#FLUX: --job-name=STREAM_INFERENCE_SUMMARIZE_GD1_INFERENCE
#FLUX: -c=4
#FLUX: -t=604800
#FLUX: --urgency=16

out=$BASE/out
mkdir -p $out
if [ ! -f $out/summary-gd1-inference.ipynb -o $PROJECT_FORCE_RERUN -ne 0 ]; then
    papermill summary-gd1-inference.ipynb $out/summary-gd1-inference.ipynb
fi
