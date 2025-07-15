#!/bin/bash
#FLUX: --job-name=astute-signal-4974
#FLUX: --queue=dept_cpu
#FLUX: --priority=16

cd ..
ls
cd ~/Data
mkdit mol-results
tar -xvf Zinc.tar.bz2
echo "Success!"
