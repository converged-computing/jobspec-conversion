#!/bin/bash
#FLUX: --job-name="test"       # Name of job
#FLUX: --priority=16

source activate /projects/e31408/users/gmg0603/project/env
python create_predictions.py
