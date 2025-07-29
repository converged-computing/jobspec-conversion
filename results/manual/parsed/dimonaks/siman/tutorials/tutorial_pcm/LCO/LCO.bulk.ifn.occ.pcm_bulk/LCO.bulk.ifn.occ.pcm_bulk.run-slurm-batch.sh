#!/bin/bash
#FLUX: --job-name=LCO.bulk.ifn.occ.pcm_bulk
#FLUX: -n=16
#FLUX: --queue=AMG-medium
#FLUX: -t=259200
#FLUX: --urgency=16

export PATH='$PATH:/home/a.boev/tools/'

cd /home/a.boev//LCO//LCO.bulk.ifn.occ.pcm_bulk/
module load Compiler/Intel/17u8; module load Q-Ch/VASP/5.4.4_OMC; module load ScriptLang/python/3.6i_2018u3
 ulimit -s unlimited
export PATH=$PATH:/home/a.boev/tools/
touch RUNNING
cp 1.POSCAR POSCAR
mpirun vasp_std >LCO.bulk.ifn.occ.pcm_bulk.1.log
sleep 20
mv OUTCAR 1.OUTCAR
mv CONTCAR 1.CONTCAR
mv CHG 1.CHG
mv CHGCAR 1.CHGCAR
mv LOCPOT 1.LOCPOT
rm XDATCAR EIGENVAL PROCAR LOCPOT vasprun.xml OSZICAR WAVEDER AECCAR0 WAVECAR ELFCAR DOSCAR PARCHG AECCAR2 CHG 
rm RUNNING
