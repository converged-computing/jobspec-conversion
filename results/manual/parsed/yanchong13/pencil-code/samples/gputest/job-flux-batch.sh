#!/bin/bash
#FLUX: --job-name=outstanding-blackbean-8158
#FLUX: --priority=16

rm -f LOCK
./start.csh
touch data/jobid.dat
./run.csh
