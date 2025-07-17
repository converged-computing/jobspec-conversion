#!/bin/bash
#FLUX: --job-name=GPU-Test
#FLUX: --queue=gpu
#FLUX: -t=10800
#FLUX: --urgency=16

module load intel/2020.4  ompi/4.1.2 lammps-gpu/24Mar22
echo "Starting run at: `date`"
ngpus=1
ncpus=1
lmp_exec=lmp_gpu
lmp_input="in.metal"
lmp_output="log-${ngpus}-gpus-${ncpus}-cpus.txt"
mpirun -np ${ncpus} lmp_gpu -sf gpu -pk gpu ${ngpus} -log ${lmp_output} -in ${lmp_input}
echo "Program finished with exit code $? at: `date`"
