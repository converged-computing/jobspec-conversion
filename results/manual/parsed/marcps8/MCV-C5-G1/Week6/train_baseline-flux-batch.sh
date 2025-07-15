#!/bin/bash
#FLUX: --job-name=loopy-cupcake-4818
#FLUX: --urgency=16

python model/baseline_InceptionResnetV1.py ./data train
