#!/bin/bash
#FLUX: --job-name=par_pi_job
#FLUX: -t=1800
#FLUX: --urgency=16

darts=(1e3 1e6 1e9)
processors=(1 2 4 8 16 32)
for d in "${darts[@]}"; do
    for p in "${processors[@]}"; do
        srun -n $p --time=1:00:00 par_pi_calc_Q3.exe $d >> output.txt
    done
done
