#!/bin/bash
#FLUX: --job-name=s-250-2000
#FLUX: -c=7
#FLUX: --urgency=16

module purge
module load cudatoolkit/10.0
module load cudnn/cuda-10.0/7.6.3
module load openmpi/gcc/3.1.3/64
LAMMPS_EXE=/home/ppiaggi/Programs/Software-deepmd-kit-1.0/lammps-git2/src/lmp_mpi
source /home/ppiaggi/Programs/Software-deepmd-kit-1.0/tensorflow-venv/bin/activate
mpirun $LAMMPS_EXE -i in.lammps.sample
if [ -f "Sampledone.txt" ]; then
    echo "Simulation finished"
elif ! grep -q 'ERROR' slurm*; then
    echo "Continuing NPT sampling"
    sbatch --dependency=afterok:$SLURM_JOB_ID run.sample.qs
else
    echo "There is an error"
fi
