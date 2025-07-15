#!/bin/bash
#FLUX: --job-name=processing
#FLUX: --queue=savio
#FLUX: -t=86520
#FLUX: --priority=16

module load ml/tensorflow/2.5.0-py37 libsndfile
python export_job.sh
