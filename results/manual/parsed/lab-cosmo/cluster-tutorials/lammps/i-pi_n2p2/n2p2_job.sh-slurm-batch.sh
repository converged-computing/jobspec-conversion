#!/bin/bash
#FLUX: --job-name=n2p2
#FLUX: --exclusive
#FLUX: --queue=jobs
#FLUX: -t=86400
#FLUX: --urgency=16

source $HOME/venv/base/bin/activate
module load intel
module load intel-mkl
module load intel-mpi
module load lammps
IPI=$HOME/code/i-pi/bin/i-pi
LAMMPS=lmp_mpi
cd scpimd1hvt4
rm /tmp/ipi_scpimd1hvt4
sleep 1
${IPI} input.xml > i-pi.log &
sleep 5
srun --time=24:00:00 --hint=nomultithread --exclusive -n ${SLURM_NTASKS} ${LAMMPS} -i in.lmp > log.lammps &
wait
exit 0
