#!/bin/bash
#FLUX: --job-name=space_cpm
#FLUX: -t=28800
#FLUX: --priority=16

python src/space_ray.py  --mode spl --test features/cpm_test.csv --instances features/cpm_train.csv
