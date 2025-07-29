#!/bin/bash
#SBATCH --job-name=cSiaSiMD
#SBATCH --output=outputs/cSiaSiMD-%j.output
#SBATCH --mail-user=dgunruh@ucdavis.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --time=1-00:00:00
#SBATCH --array=0-3

export t='$SLURM_ARRAY_TASK_ID'

export t=$SLURM_ARRAY_TASK_ID
module load lammps
s=21248+100*$t
dumpA=aSi-$t.xyz
dumpsnapA=aSiBox-$t.xyz
dumpI=cSiaSiInterface-$t.xyz
dumpsnapI=cSiaSiInterfaceSnapshot-$t.xyz
mpirun lmp_mpi -var s $s -var d $dumpA -var ds $dumpsnapA -in createAmorphousSi.in
mpirun lmp_mpi -var s $s -var d $dumpI -var dA $dumpA -var ds $dumpsnapI -in mergeAmorphousCrystalline.in
