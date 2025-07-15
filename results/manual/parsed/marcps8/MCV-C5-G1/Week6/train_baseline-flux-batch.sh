#!/bin/bash
#FLUX: --job-name=chocolate-motorcycle-0049
#FLUX: --priority=16

python model/baseline_InceptionResnetV1.py ./data train
