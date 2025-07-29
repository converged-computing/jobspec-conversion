#!/bin/bash
#SBATCH --job-name=mergeSi2
#SBATCH --output=outputs/cSiaSiMD-%j.output
#SBATCH --mail-user=dgunruh@ucdavis.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=64
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=250G
#SBATCH --time=2-00:00:00
#SBATCH --partition=med2
#SBATCH --constraint=ntasks-per-node=64

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export j='$SLURM_JOB_ID'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export j=$SLURM_JOB_ID
module load openmpi
s=$j   # 124248+$j+$t
displacement=2.97
change=3.14
dumpA=bulk_heatstrip-$displacement-$change.xyz
dumpsnapA=box_heatstrip-$displacement-$change.xyz
srun ../lammps_3Mar2020/build/lmp_mpi -var s $s -var disp $displacement -var cng $change -var d $dumpA -var ds $dumpsnapA -in heatStrip.in
