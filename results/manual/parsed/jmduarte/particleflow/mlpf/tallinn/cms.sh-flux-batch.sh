#!/bin/bash
#FLUX: --job-name=pusheena-pot-8487
#FLUX: --urgency=16

IMG=/home/software/singularity/tf26.simg:latest
cd ~/particleflow
PYTHONPATH=hep_tfds singularity exec -B /scratch-persistent --nv $IMG python3 mlpf/pipeline.py train -c parameters/cms.yaml --plot-freq 1
