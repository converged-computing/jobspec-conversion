#!/bin/bash
#FLUX: --job-name=persnickety-lentil-2889
#FLUX: --queue=gputest
#FLUX: -t=300
#FLUX: --urgency=16

rm -f LOCK
./start.csh
touch data/jobid.dat
./run.csh
