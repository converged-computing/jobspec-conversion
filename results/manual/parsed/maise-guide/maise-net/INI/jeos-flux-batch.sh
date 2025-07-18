#!/bin/bash
#FLUX: --job-name=salted-chip-8593
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
EXE=/opt/ohpc/pub/apps/VASP/vasp.5.4.4/bin/vasp_std
sed -i 's/NSW=0/NSW=20/' INCAR
python maisenet_kmsh.py KKKK
mpirun $EXE  > out
mv POSCAR    POSCAR.1
mv CONTCAR   CONTCAR.1
mv OUTCAR    OUTCAR.1
mv OSZICAR   OSZICAR.1
cp INCAR     incar.1
cp KPOINTS   kpoints.1
cp CONTCAR.1 POSCAR
python maisenet_kmsh.py KKKK
mpirun $EXE  > out
mv POSCAR    POSCAR.2
mv CONTCAR   CONTCAR.2
mv OUTCAR    OUTCAR.2
mv OSZICAR   OSZICAR.2
cp INCAR     incar.2
cp KPOINTS   kpoints.2
cp CONTCAR.2 POSCAR
python maisenet_kmsh.py KKKK
mpirun $EXE  > out
mv POSCAR    POSCAR.3
mv CONTCAR   CONTCAR.3
mv OUTCAR    OUTCAR.3
mv OSZICAR   OSZICAR.3
cp INCAR     incar.3
cp KPOINTS   kpoints.3
cp CONTCAR.3 POSCAR
sed -i 's/NSW=20/NSW=0/' INCAR
python maisenet_kmsh.py KKKK
mpirun $EXE  > out
mv POSCAR    POSCAR.0
mv CONTCAR   CONTCAR.0
mv OUTCAR    OUTCAR.0
mv OSZICAR   OSZICAR.0
rm IB* EI* PC* XD* CH* WA* vasp* DO* maisenet_kmsh.py
