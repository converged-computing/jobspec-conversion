#!/bin/bash
#FLUX: --job-name=swampy-omelette-1750
#FLUX: --urgency=16

module reset
module load NAMD
echo "NAMD_TINKERCLIFFS ROME: Normal beginning of execution."
ls -la
srun namd2 ./ubq_wb_eq.conf > namd_tinkercliffs_rome.txt
if [ $? -ne 0 ]; then
  echo "NAMD_TINKERCLIFFS ROME: Run error."
  exit 1
fi
echo "NAMD_TINKERCLIFFS ROME: Normal end of execution."
exit 0
