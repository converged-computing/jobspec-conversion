#!/bin/bash
#FLUX: --job-name=fugly-cinnamonbun-5957
#FLUX: --exclusive
#FLUX: --priority=16

echo "This is Job $SLURM_JOB_ID"
module load gcc
cd /home/kurse/kurs1/ui31dymo/Lap1/SPP_Uebungen/source_parktikum_c
./main text1.txt text4.txt
