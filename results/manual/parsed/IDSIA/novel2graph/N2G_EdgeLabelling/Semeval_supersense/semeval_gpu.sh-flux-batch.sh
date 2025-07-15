#!/bin/bash
#FLUX: --job-name=strawberry-noodle-9179
#FLUX: --queue=debug-gpu
#FLUX: -t=14400
#FLUX: --priority=16

python Supersense_semeval.py
