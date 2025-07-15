#!/bin/bash
#FLUX: --job-name=hello-hope-1371
#FLUX: --queue=dept_cpu
#FLUX: --urgency=16

cd ..
ls
cd ~/Data
mkdit mol-results
tar -xvf Zinc.tar.bz2
echo "Success!"
