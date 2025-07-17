#!/bin/bash
#FLUX: --job-name=stanky-banana-5975
#FLUX: -c=7
#FLUX: -t=86400
#FLUX: --urgency=16

module load cudatoolkit/10.0
module load cudnn/cuda-10.0/7.6.3
module load openmpi/gcc/3.1.3/64
source /home/tgartner/Software-deepmd-kit-1.0/tensorflow-venv/bin/activate
module load /home/tgartner/modulefiles/plumed-tg
if [ -f "Sampledone.txt" ]; then
    echo "Simulation finished"
elif ! grep -q 'ERROR' slurm*; then
    echo "Continuing NPT sampling"
    sbatch --dependency=afterany:$SLURM_JOB_ID run.sample.qs
    # run NPT sampling
    mpirun /home/tgartner/Software-deepmd-kit-1.0/lammps-3Mar20/src/lmp_mpi -i in.lammps.sample -e screen
else
    echo "There is an error"
fi
