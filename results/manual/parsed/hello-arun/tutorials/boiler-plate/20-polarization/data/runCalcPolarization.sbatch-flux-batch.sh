#!/bin/bash
#FLUX: --job-name=__jobName
#FLUX: --queue=batch
#FLUX: -t=10800
#FLUX: --urgency=16

export VASP_CMD='/ibex/scratch/jangira/vasp/sw/vasp.5.4.4/bin/vasp_std'
export OMP_NUM_THREADS='1'

srcDIR=$(pwd)
module load intel/2016
module load openmpi/4.0.3_intel
export VASP_CMD=/ibex/scratch/jangira/vasp/sw/vasp.5.4.4/bin/vasp_std
export OMP_NUM_THREADS=1
echo """
       JobId: ${SLURM_JOB_ID}
    NodeList: ${SLURM_JOB_NODELIST}
"""
mpirun -np ${SLURM_NPROCS} ${VASP_CMD}
cd $srcDIR
calcDIR="${srcDIR}/pol-LBERRY"
mkdir -p $calcDIR
cp CHG* WAVECAR KPOINTS INCAR POTCAR "${calcDIR}/"
cp CONTCAR $calcDIR/POSCAR
sed -i "/ISTART/c\ISTART=1" $calcDIR/INCAR
sed -i "/ICHARG/c\ICHARG=1" $calcDIR/INCAR
sed -i "/NSW/c\NSW = 0" $calcDIR/INCAR
sed -i "/IBRION/c\IBRION = -1" $calcDIR/INCAR
sed -i "/LVHAR/c\LVHAR = False" $calcDIR/INCAR
sed -i "/LAECHG/c\LAECHG = False" $calcDIR/INCAR
sed -i "/LELF/c\LELF = False" $calcDIR/INCAR
echo """\
LBERRY = .TRUE.
IGPAR = 1 # 1: x-axis, 2:y-axis ...
NPPSTR = 16
""" >> $calcDIR/INCAR
cd $calcDIR
mpirun -np ${SLURM_NPROCS} ${VASP_CMD} >lberry.log 2>&1
