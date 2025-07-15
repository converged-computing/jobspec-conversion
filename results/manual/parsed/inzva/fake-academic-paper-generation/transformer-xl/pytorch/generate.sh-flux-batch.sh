#!/bin/bash
#FLUX: --job-name=generate_text
#FLUX: -c=20
#FLUX: --queue=short
#FLUX: -t=14400
#FLUX: --priority=16

srun python inference.py
