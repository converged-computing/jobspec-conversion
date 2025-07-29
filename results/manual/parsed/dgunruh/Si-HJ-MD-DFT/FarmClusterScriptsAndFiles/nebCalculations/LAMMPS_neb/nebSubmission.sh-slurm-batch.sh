#!/bin/bash
#SBATCH --job-name=NEB
#SBATCH --output=outputs/cSiaSiMD-%j.output
#SBATCH --mail-user=dgunruh@ucdavis.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=64
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=50G
#SBATCH --time=00:01:00
#SBATCH --constraint=ntasks-per-node=16
#SBATCH --array=14-14

export OMP_NUM_THREADS='1'
export j='$SLURM_JOB_ID'
export t='$SLURM_ARRAY_TASK_ID'

export OMP_NUM_THREADS=1
export j=$SLURM_JOB_ID
export t=$SLURM_ARRAY_TASK_ID
module load openmpi
s=$j   # 124248+$j+$t
temp=09132020${t}
log=09132020logs/${t}
addendum=55
inputs=inputs/09-13-2020_inputs
beginning=$inputs/neb_input_${t}.out
ending=$inputs/neb_end_${t}.out
idfile=$inputs/neb_atoms_${t}.out
dump=neb_calc_result_${temp}_${s}_${t}
pNum=32
srun ../lammps_3Mar2020/build/lmp_mpi -var i $beginning -var f $ending -var pNum $pNum -var idfile $idfile -var dumpfile $dump -log logfiles/${log}/log.lammps -screen screenfiles/screen${temp} -partition ${pNum}x2 -in nebGAP.in
