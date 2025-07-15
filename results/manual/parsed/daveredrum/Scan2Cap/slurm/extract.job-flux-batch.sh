#!/bin/bash
#FLUX: --job-name=prep                           # Job name
#FLUX: --priority=16

date;hostname;pwd
python scripts/compute_multiview_features.py
