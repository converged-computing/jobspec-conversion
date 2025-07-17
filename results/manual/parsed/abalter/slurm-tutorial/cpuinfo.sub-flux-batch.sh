#!/bin/bash
#FLUX: --job-name=cpuinfo
#FLUX: -t=3600
#FLUX: --urgency=16

echo "cat /proc/cpuinfo | grep "model name" | uniq"
cat /proc/cpuinfo | grep "model name" | uniq
echo "srun cat /proc/cpuinfo | grep "model name" | uniq"
srun cat /proc/cpuinfo | grep "model name" | uniq
