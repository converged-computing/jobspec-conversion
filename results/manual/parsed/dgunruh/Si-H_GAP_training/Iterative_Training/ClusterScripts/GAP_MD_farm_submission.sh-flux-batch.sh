#!/bin/bash
#FLUX: --job-name=GAP_MD
#FLUX: -n=128
#FLUX: --queue=med2
#FLUX: -t=172800
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'

export OMP_NUM_THREADS=1
t=$SLURM_ARRAY_TASK_ID
j=$SLURM_JOB_ID
operation=$1 # options are: optimize, lowAnneal, medAnneal, highAnneal
phase=$2 # options are: amorph, liquid, vacancy, divacancy, interstitial
folder=$3
module load openmpi
s=$((j+100*t))   # 124248+$j+$t
inputfile=inputs/${folder}/GAP_${operation}_${phase}_${t}.xyz
dump=dumpseriesoutputs/${folder}/GAP_${operation}_${phase}_dumpseries$t.xyz
dumpsnap=dumpoutputs/${folder}/GAP_${operation}_${phase}_dump$t.xyz
srun ../lammps_3Mar2020/build/lmp_mpi -var s $s -var i $inputfile -var d $dump -var ds $dumpsnap -in ${operation}.in
