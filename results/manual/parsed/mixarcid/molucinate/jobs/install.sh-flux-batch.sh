#!/bin/bash
#FLUX: --job-name=install
#FLUX: --queue=dept_cpu
#FLUX: -t=1800
#FLUX: --urgency=16

cd ..
ls
cd ~/Data
mkdit mol-results
tar -xvf Zinc.tar.bz2
echo "Success!"
