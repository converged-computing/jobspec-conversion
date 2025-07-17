#!/bin/bash
#FLUX: --job-name=rvae_sp
#FLUX: -n=16
#FLUX: --queue=short
#FLUX: --urgency=16

sacct --format="CPUTime,MaxRSS"
python ../RobustVariationalAutoencoder.py
