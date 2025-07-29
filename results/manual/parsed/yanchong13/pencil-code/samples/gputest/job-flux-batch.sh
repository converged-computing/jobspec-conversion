#!/bin/bash
#FLUX --job-name=dirty-itch-6561
#FLUX --queue=gputest
#FLUX -t=300
#FLUX --urgency=16

rm -f LOCK
./start.csh
touch data/jobid.dat
./run.csh
