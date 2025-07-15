#!/bin/bash
#FLUX: --job-name=chocolate-pastry-7951
#FLUX: -c=8
#FLUX: -t=3540
#FLUX: --urgency=16

source ~/.bash_functions
mod_py39
source activate eso
NARRAY=10
NCHUNK=$((365 / $NARRAY))
dstart=$((1 + ($SLURM_ARRAY_TASK_ID - 1) * ($NCHUNK+1)))
dend=$(($dstart + $NCHUNK))
if [[ $dend -gt 365 ]]; then
  dend=365
fi
echo "Processing DOYs $dstart to $dend"
doys=$(seq $dstart $dend)
for d in $doys; do
  echo "Processing DOY $d"
  python kerchunk-dask-byhand.py --year=2022 --doy=$d
done
