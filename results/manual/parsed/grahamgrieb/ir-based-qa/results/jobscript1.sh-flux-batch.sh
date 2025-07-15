#!/bin/bash
#FLUX: --job-name=test1
#FLUX: --urgency=16

source activate /projects/e31408/users/gmg0603/project/env
python create_predictions_with_top_retrieval.py
