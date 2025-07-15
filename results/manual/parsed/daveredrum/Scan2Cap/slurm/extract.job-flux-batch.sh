#!/bin/bash
#FLUX: --job-name=prep
#FLUX: --urgency=16

date;hostname;pwd
python scripts/compute_multiview_features.py
