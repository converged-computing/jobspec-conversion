#!/bin/bash
#FLUX: --job-name=conspicuous-sundae-9701
#FLUX: --priority=16

export PATH='$PATH:/home/a.boev/tools/'

cd /home/a.boev//LCO//LCO.104.ifn.occ.ifw.pcm_suf_ec/
module load Compiler/Intel/17u8; module load Q-Ch/VASP/5.4.4_SOL; module load ScriptLang/python/3.6i_2018u3
 ulimit -s unlimited
export PATH=$PATH:/home/a.boev/tools/
touch RUNNING
cp 1.POSCAR POSCAR
mpirun vasp_std >LCO.104.ifn.occ.ifw.pcm_suf_ec.1.log
sleep 20
mv OUTCAR 1.OUTCAR
mv CONTCAR 1.CONTCAR
mv CHG 1.CHG
mv CHGCAR 1.CHGCAR
mv LOCPOT 1.LOCPOT
rm vasprun.xml XDATCAR PROCAR AECCAR0 EIGENVAL ELFCAR OSZICAR PARCHG WAVEDER DOSCAR AECCAR2 WAVECAR 
rm RUNNING
