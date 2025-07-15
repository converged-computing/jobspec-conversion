#!/bin/bash
#FLUX: --job-name=gloopy-car-9476
#FLUX: -c=7
#FLUX: --urgency=16

module load cudatoolkit/10.0
module load cudnn/cuda-10.0/7.6.3
module load openmpi/gcc/3.1.3/64
source /home/tgartner/Software-deepmd-kit-1.0/tensorflow-venv/bin/activate
module load /home/tgartner/modulefiles/plumed-tg
mpirun /home/tgartner/Software-deepmd-kit-1.0/lammps-3Mar20/src/lmp_mpi -i in.lammps.init
rm in.boxdimensions
python BoxDimensions.py > in.boxdimensions
mpirun /home/tgartner/Software-deepmd-kit-1.0/lammps-3Mar20/src/lmp_mpi -i in.lammps.equil
if ! grep -q 'ERROR' slurm*; then
    echo "Continuing equilibration"
    sbatch --dependency=afterok:$SLURM_JOB_ID run.sample.qs
else
    echo "There is an error"
fi
