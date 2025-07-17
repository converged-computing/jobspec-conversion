#!/bin/bash
#FLUX: --job-name=v200h3
#FLUX: -c=4
#FLUX: --queue=standard
#FLUX: -t=86400
#FLUX: --urgency=16

eval "$(conda shell.bash hook)"
conda activate 608proj
python3 test_vi.py --seed 44 --horizon 200 --episode 5
