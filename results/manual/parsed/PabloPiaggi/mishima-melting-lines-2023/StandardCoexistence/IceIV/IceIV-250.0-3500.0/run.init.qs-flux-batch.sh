#!/bin/bash
#FLUX: --job-name=i-250-3500
#FLUX: -c=7
#FLUX: --urgency=16

module purge
module load cudatoolkit/10.0
module load cudnn/cuda-10.0/7.6.3
module load openmpi/gcc/3.1.3/64
LAMMPS_EXE=/home/ppiaggi/Programs/Software-deepmd-kit-1.0/lammps-git2/src/lmp_mpi
source /home/ppiaggi/Programs/Software-deepmd-kit-1.0/tensorflow-venv/bin/activate
mpirun $LAMMPS_EXE -i in.lammps.init
rm in.boxdimensions
python BoxDimensions.py > in.boxdimensions
mpirun $LAMMPS_EXE -i in.lammps.equil
if ! grep -q 'ERROR' slurm*; then
    echo "Continuing equilibration"
    sbatch --dependency=afterok:$SLURM_JOB_ID run.sample.qs
else
    echo "There is an error"
fi
