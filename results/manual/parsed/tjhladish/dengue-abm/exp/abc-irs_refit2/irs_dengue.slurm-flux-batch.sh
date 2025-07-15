#!/bin/bash
#FLUX: --job-name=irs-dengue
#FLUX: --queue=hpg2-compute
#FLUX: -t=86400
#FLUX: --priority=16

module load gcc/7.3.0 gsl
for i in `seq 1 1`;
do
    ./abc_sql run_posterior.json --simulate
done
