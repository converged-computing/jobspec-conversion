#!/bin/bash
#FLUX: --job-name=STREAM_INFERENCE_SUMMARIZE_MOCK_INFERENCE
#FLUX: -c=4
#FLUX: -t=604800
#FLUX: --urgency=16

out=$BASE/out
mkdir -p $out
if [ ! -f $out/summary-mock-inference.ipynb -o $PROJECT_FORCE_RERUN -ne 0 ]; then
    papermill summary-mock-inference.ipynb $out/summary-mock-inference.ipynb
fi
