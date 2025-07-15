#!/bin/bash
#FLUX: --job-name=bPtO2-nvt
#FLUX: -n=5
#FLUX: -c=4
#FLUX: --queue=k2-hipri
#FLUX: -t=1800
#FLUX: --urgency=16

module purge
module load services/s3cmd
module load libs/intel/2016u1
module load libs/intel-mkl/2016u1/bin
module load mpi/intel-mpi/2016u1/bin
conda activate dpdev
srun --ntasks=1 --cpus-per-task=4 cd 100 && mpirun -n 4 lmp -in in.lammps 2>&1 > lmp.out && cd - &
srun --ntasks=1 --cpus-per-task=4 cd 200 && mpirun -n 4 lmp -in in.lammps 2>&1 > lmp.out && cd - &
srun --ntasks=1 --cpus-per-task=4 cd 300 && mpirun -n 4 lmp -in in.lammps 2>&1 > lmp.out && cd - &
srun --ntasks=1 --cpus-per-task=4 cd 400 && mpirun -n 4 lmp -in in.lammps 2>&1 > lmp.out && cd - &
srun --ntasks=1 --cpus-per-task=4 cd 500 && mpirun -n 4 lmp -in in.lammps 2>&1 > lmp.out && cd - &
wait
