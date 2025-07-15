#!/bin/bash
#FLUX: --job-name=gassy-hobbit-5710
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
EXE=/opt/ohpc/pub/apps/VASP/vasp.5.4.4/bin/vasp_std
python maisenet_kmsh.py KKKK
date        >> id
mpirun $EXE  > out
date        >> id
mv POSCAR    POSCAR.0
mv CONTCAR   CONTCAR.0
mv OUTCAR    OUTCAR.0
mv OSZICAR   OSZICAR.0
rm IB* EI* PC* XD* CH* WA* vasp* DO* maisenet_kmsh.py
