#!/bin/bash
#SBATCH --job-name=mergeSi2
#SBATCH --output=outputs/cSiaSiMD-%j.output
#SBATCH --mail-user=dgunruh@ucdavis.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=64
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=50G
#SBATCH --time=00:00:30
#SBATCH --partition=med2
#SBATCH --constraint=ntasks-per-node=16
#SBATCH --array=33-64

export OMP_NUM_THREADS='1'
export j='$SLURM_JOB_ID'
export t='$SLURM_ARRAY_TASK_ID'

export OMP_NUM_THREADS=1
export j=$SLURM_JOB_ID
export t=$SLURM_ARRAY_TASK_ID
module load openmpi
s=$j   # 124248+$j+$t
temp=aSi${t}
log=aSi/${temp}
addendum=55
beginning=inputs/neb_input_${temp}.out
ending=inputs/neb_end_${temp}.out
idfile=inputs/neb_atoms_${temp}.out
dump=neb_calc_result_${temp}_${s}_${t}
pNum=32
srun ../lammps_3Mar2020/build/lmp_mpi -var i $beginning -var f $ending -var pNum $pNum -var idfile $idfile -var dumpfile $dump -log logfiles/${log}/log.lammps -screen screenfiles/screen${temp} -partition ${pNum}x2 -in nebGAP.in
