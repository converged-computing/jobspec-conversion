#!/bin/bash
#FLUX: --job-name=SnSe-0.08
#FLUX: --queue=batch
#FLUX: -t=1800
#FLUX: --urgency=16

srcDIR=$(pwd)
machine="IBEX" # HPC or IBEX
if [[ $machine == "IBEX" ]]; then
    module load intel/2016
    module load openmpi/4.0.3_intel
    export VASP_CMD=/ibex/scratch/jangira/vasp/sw/vasp.5.4.4/bin/vasp_std
    export OMP_NUM_THREADS=1
elif [[ $machine == "HPC" ]]; then
    # Test with care and HPC vasp is not compiled
    # with constrained relaxation functionality
    module load intel-mkl/2020.0.166/intel-19.1.0.166-wxnxb2u
    module load openmpi/3.1.5/intel-19.1.0.166-6slj4uh
    export VASP_CMD=/home/jangira/Documents/applications/vasp/bin/vasp_std
    export OMP_NUM_THREADS=1
    SLURM_NPROCS=24
fi
mpirun -np ${SLURM_NPROCS} ${VASP_CMD}
cd $srcDIR
calcDIR="${srcDIR}/pol-LBERRY"
mkdir -p $calcDIR
cp CHG* WAVECAR KPOINTS INCAR POTCAR grep-pol.sh "${calcDIR}/"
cp CONTCAR $calcDIR/POSCAR
sed -i "/ISTART/c\ISTART=1" $calcDIR/INCAR
sed -i "/ICHARG/c\ICHARG=1" $calcDIR/INCAR
echo """\
LBERRY = .TRUE.
IGPAR = 3
NPPSTR = 3
""" >> $calcDIR/INCAR
cd $calcDIR
mpirun -np ${SLURM_NPROCS} ${VASP_CMD} > std.out
rm $srcDIR/grep-pol.sh
