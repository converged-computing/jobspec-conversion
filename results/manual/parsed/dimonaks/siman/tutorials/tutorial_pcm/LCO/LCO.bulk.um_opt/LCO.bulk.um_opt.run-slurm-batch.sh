#!/bin/bash
#SBATCH --job-name=LCO.bulk.um_opt
#SBATCH --output=/home/a.boev//LCO//LCO.bulk.um_opt/sbatch.out
#SBATCH --error=/home/a.boev//LCO//LCO.bulk.um_opt/sbatch.err
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --partition=AMG-medium

export PATH='$PATH:/home/a.boev/tools/'

cd /home/a.boev//LCO//LCO.bulk.um_opt/
module load Compiler/Intel/17u8; module load Q-Ch/VASP/5.4.4_OPT; module load ScriptLang/python/3.6i_2018u3
 ulimit -s unlimited
export PATH=$PATH:/home/a.boev/tools/
touch RUNNING
cp 1.POSCAR POSCAR
mpirun vasp_std >LCO.bulk.um_opt.1.log
sleep 20
mv OUTCAR 1.OUTCAR
mv CONTCAR 1.CONTCAR
mv CHGCAR 1.CHGCAR
rm XDATCAR EIGENVAL PROCAR LOCPOT vasprun.xml OSZICAR WAVEDER AECCAR0 WAVECAR ELFCAR DOSCAR PARCHG AECCAR2 CHG 
rm RUNNING
