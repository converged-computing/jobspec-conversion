#!/bin/bash
#FLUX: --job-name=peachy-parrot-3560
#FLUX: -t=259200
#FLUX: --urgency=16

time python run_Speed_up.py --contigs test.fasta --len 1999
