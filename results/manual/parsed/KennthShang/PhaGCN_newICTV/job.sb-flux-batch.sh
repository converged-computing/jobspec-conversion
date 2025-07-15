#!/bin/bash
#FLUX: --job-name=confused-onion-8446
#FLUX: -t=259200
#FLUX: --priority=16

time python run_Speed_up.py --contigs test.fasta --len 1999
