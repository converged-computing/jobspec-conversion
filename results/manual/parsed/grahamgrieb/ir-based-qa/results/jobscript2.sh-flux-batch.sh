#!/bin/bash
#FLUX: --job-name=test2
#FLUX: --urgency=16

source activate /projects/e31408/users/gmg0603/project/env
python create_predictions_with_topn_retrieval.py
