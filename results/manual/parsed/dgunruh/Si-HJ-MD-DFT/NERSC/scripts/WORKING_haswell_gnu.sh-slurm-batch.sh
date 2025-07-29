#!/bin/bash
#SBATCH --job-name=cSiaSiMD
#SBATCH --output=outputs/cSiaSiMD-%j.output
#SBATCH --mail-user=dgunruh@ucdavis.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --cpus-per-task=2
#SBATCH --mem-per-cpu=118G
#SBATCH --time=00:10:00
#SBATCH --qos=debug
#SBATCH --constraint=haswell

export OMP_NUM_THREADS='2'
export j='$SLURM_JOB_ID'

export OMP_NUM_THREADS=2
export j=$SLURM_JOB_ID
s=$j
dumpA=aSi-GAP-$j.xyz
dumpsnapA=aSiBox-GAP-$j.xyz
srun --cpu_bind=cores /global/common/software/m3634/lammps_3Mar2020/gnubuild_haswell/lmp_gnu_haswell -var s $s -var d $dumpA -var ds $dumpsnapA -in createAmorphousSi.in
