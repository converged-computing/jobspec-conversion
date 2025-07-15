#!/bin/bash
#FLUX: --job-name=rvae_sp
#FLUX: --urgency=16

sacct --format="CPUTime,MaxRSS"
python ../RobustVariationalAutoencoder.py
