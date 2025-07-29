#!/bin/bash
#SBATCH --job-name=LCO.104.um_opt_suf
#SBATCH --output=/home/a.boev//LCO//LCO.104.um_opt_suf/sbatch.out
#SBATCH --error=/home/a.boev//LCO//LCO.104.um_opt_suf/sbatch.err
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --partition=AMG-medium

export PATH='$PATH:/home/a.boev/tools/'

cd /home/a.boev//LCO//LCO.104.um_opt_suf/
module load Compiler/Intel/17u8; module load Q-Ch/VASP/5.4.4_OPT; module load ScriptLang/python/3.6i_2018u3
 ulimit -s unlimited
export PATH=$PATH:/home/a.boev/tools/
touch RUNNING
cp 1.POSCAR POSCAR
mpirun vasp_std >LCO.104.um_opt_suf.1.log
sleep 20
mv OUTCAR 1.OUTCAR
mv CONTCAR 1.CONTCAR
mv CHGCAR 1.CHGCAR
rm XDATCAR EIGENVAL PROCAR LOCPOT vasprun.xml OSZICAR WAVEDER AECCAR0 WAVECAR ELFCAR DOSCAR PARCHG AECCAR2 CHG 
rm RUNNING
