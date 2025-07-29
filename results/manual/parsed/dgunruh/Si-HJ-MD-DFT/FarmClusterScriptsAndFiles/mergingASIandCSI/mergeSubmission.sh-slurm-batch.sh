#!/bin/bash
#SBATCH --job-name=cSiaSiGAP
#SBATCH --output=outputs/cSiaSiMD-%j.output
#SBATCH --mail-user=dgunruh@ucdavis.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=2
#SBATCH --mem-per-cpu=60G
#SBATCH --time=2-00:00:00
#SBATCH --partition=high
#SBATCH --constraint=ntasks-per-node=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export j='$SLURM_JOB_ID'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export j=$SLURM_JOB_ID
module load openmpi
s=$j   # 124248+$j+$t
dumpA=aSi-GAP-$j.xyz
dumpsnapA=aSiBox-GAP-$j.xyz
srun ../src/lammps-stable_3Mar2020/build/lmp_mpi -var s $s -var d $dumpA -var ds $dumpsnapA -in mergeAmorphousCrystallineGAP.in
