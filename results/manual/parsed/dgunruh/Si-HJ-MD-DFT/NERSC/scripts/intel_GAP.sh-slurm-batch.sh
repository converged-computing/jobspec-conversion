#!/bin/bash
#SBATCH --job-name=cSiaSiMD
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
#SBATCH --array=0-14

export OMP_NUM_THREADS='1'

export OMP_NUM_THREADS=1
j=$SLURM_JOB_ID
t=$SLURM_ARRAY_TASK_ID
pe=${PE_ENV,,}
if [ $pe != "intel" ]; then
	module swap PrgEnv-$pe PrgEnv-intel
fi
s=$((j + 100*t))
dumpA=aSi-GAP-$j-$t.xyz
dumpsnapA=aSiBox-GAP-$j-$t.xyz
srun --cpu_bind=cores /global/common/software/m3634/lammps_3Mar2020/intelbuild/lmp_intel -var s $s -var d $dumpA -var ds $dumpsnapA -in createAmorphousSiIntel.in
