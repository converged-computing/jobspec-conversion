#!/bin/bash
#SBATCH --job-name=cSiaSiMD
#SBATCH --output=outputs/cSiaSiMD-%j.output
#SBATCH --mail-user=dgunruh@ucdavis.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=87G
#SBATCH --time=00:10:00
#SBATCH --qos=debug
#SBATCH --constraint=knl

export OMP_PROC_BIND='true'
export OMP_PLACES='threads'
export OMP_NUM_THREADS='1'
export j='$SLURM_JOB_ID'

export OMP_PROC_BIND=true
export OMP_PLACES=threads
export OMP_NUM_THREADS=1
export j=$SLURM_JOB_ID
s=$j
dumpA=aSi-GAP-$j.xyz
dumpsnapA=aSiBox-GAP-$j.xyz
srun --cpu_bind=cores /global/common/software/m3634/lammps_3Mar2020/gnubuild_KNL/lmp_gnu_knl -var s $s -var d $dumpA -var ds $dumpsnapA -in createAmorphousSi.in
