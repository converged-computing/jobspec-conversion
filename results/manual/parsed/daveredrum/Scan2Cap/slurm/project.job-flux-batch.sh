#!/bin/bash
#FLUX: --job-name=prep                           # Job name
#FLUX: --priority=16

date;hostname;pwd
python scripts/project_multiview_features.py --maxpool
