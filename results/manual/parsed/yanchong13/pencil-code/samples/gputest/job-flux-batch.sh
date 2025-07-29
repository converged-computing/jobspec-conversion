#!/bin/bash
#FLUX --job-name=dinosaur-chip-6201
#FLUX --queue=gputest
#FLUX -t=300
#FLUX --urgency=16

rm -f LOCK
./start.csh
touch data/jobid.dat
./run.csh
