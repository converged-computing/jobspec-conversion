#!/bin/bash
#SBATCH --job-name=aSiGAP
#SBATCH --output=outputs/cSiaSiMD-%j.output
#SBATCH --mail-user=dgunruh@ucdavis.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=118G
#SBATCH --time=1-00:12:00
#SBATCH --qos=regular
#SBATCH --constraint=haswell
#SBATCH --array=0-9

export OMP_NUM_THREADS='1'

export OMP_NUM_THREADS=1
j=$SLURM_JOB_ID
t=$SLURM_ARRAY_TASK_ID
pe=${PE_ENV,,}
if [ $pe != "gnu" ]; then
	module swap PrgEnv-$pe PrgEnv-gnu
fi
s=$((j+100*t))
dumpA=aSi-GAP-$j-$t.xyz
dumpsnapA=aSiBox-GAP-$j-$t.xyz
srun --cpu_bind=cores /global/common/software/m3634/lammps_3Mar2020/gnubuild_haswell/lmp_gnu_haswell -var s $s -var d $dumpA -var ds $dumpsnapA -in createAmorphousSi.in
