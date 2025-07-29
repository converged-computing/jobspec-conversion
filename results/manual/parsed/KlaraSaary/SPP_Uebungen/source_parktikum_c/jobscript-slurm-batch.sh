#!/bin/bash
#FLUX: --job-name=my_job
#FLUX: -c=16
#FLUX: --exclusive
#FLUX: --queue=kurs1
#FLUX: -t=180
#FLUX: --urgency=16

echo "This is Job $SLURM_JOB_ID"
module load gcc
cd /home/kurse/kurs1/ui31dymo/Lap1/SPP_Uebungen/source_parktikum_c
./main text1.txt text4.txt
