#!/bin/bash
#FLUX: --job-name=rvae_sp
#FLUX: --priority=16

sacct --format="CPUTime,MaxRSS"
python ../RobustVariationalAutoencoder.py
