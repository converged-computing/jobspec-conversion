#!/bin/bash
#FLUX: --job-name=rigid
#FLUX: -t=18000
#FLUX: --priority=16

module load pycharmm/0.5
python standard_rigid.py
