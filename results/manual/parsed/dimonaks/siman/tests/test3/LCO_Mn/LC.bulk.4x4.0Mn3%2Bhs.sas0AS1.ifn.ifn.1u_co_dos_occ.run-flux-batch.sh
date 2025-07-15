#!/bin/bash
#FLUX: --job-name=buttery-staircase-3267
#FLUX: --urgency=16

export PATH='$PATH:/home/a.boev/tools/'

cd /home/a.boev/vasp/surseg_tem//seg_paper/sol/as//LC.bulk.4x4.0Mn3+hs.sas0AS1.ifn.ifn.1u_co_dos_occ/
module load Compiler/Intel/17u8; module load Q-Ch/VASP/5.4.4_OMC; module load ScriptLang/python/3.6i_2018u3
 ulimit -s unlimited
export PATH=$PATH:/home/a.boev/tools/
touch RUNNING
cp 1.POSCAR POSCAR
mpirun vasp_std >LC.bulk.4x4.0Mn3+hs.sas0AS1.ifn.ifn.1u_co_dos_occ.1.log
sleep 20
mv OUTCAR 1.OUTCAR
mv CONTCAR 1.CONTCAR
mv CHGCAR 1.CHGCAR
mv DOSCAR 1.DOSCAR
mv vasprun.xml 1.vasprun.xml
rm CHG AECCAR0 AECCAR2 EIGENVAL PROCAR WAVECAR OSZICAR XDATCAR LOCPOT WAVEDER PARCHG 
rm RUNNING
