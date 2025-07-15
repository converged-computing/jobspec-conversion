#!/bin/bash
#FLUX: --job-name="test2"       # Name of job
#FLUX: --priority=16

source activate /projects/e31408/users/gmg0603/project/env
python create_predictions_with_topn_retrieval.py
