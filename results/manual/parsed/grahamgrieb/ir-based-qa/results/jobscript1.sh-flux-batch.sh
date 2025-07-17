#!/bin/bash
#FLUX: --job-name=test1
#FLUX: --queue=gengpu
#FLUX: -t=21600
#FLUX: --urgency=16

source activate /projects/e31408/users/gmg0603/project/env
python create_predictions_with_top_retrieval.py
