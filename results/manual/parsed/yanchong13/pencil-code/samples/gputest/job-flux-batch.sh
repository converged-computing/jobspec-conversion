#!/bin/bash
#FLUX: --job-name=gassy-kerfuffle-8242
#FLUX: --urgency=16

rm -f LOCK
./start.csh
touch data/jobid.dat
./run.csh
