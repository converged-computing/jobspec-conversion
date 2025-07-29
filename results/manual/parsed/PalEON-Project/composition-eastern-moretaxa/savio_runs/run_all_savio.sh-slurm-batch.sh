#!/bin/bash
#FLUX: --job-name=composition-eastern-moretaxa
#FLUX: --queue=savio2
#FLUX: -t=864000
#FLUX: --urgency=16

module load r r-packages r-spatial netcdf/4.4.1.1-gcc-s
source config-0.2-0
cp config-0.2-0 config
./fit_eastern.R >& log.fit_eastern_0.2-0
for (( i=1; i<=10; i++ )); do
    source config-0.2-${i}
    cp config-0.2-${i} config
    export OMP_NUM_THREADS=1
    ./fit_eastern.R >& log.fit_eastern_0.2-${i} &
    sleep 5
done
wait
