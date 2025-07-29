#!/bin/bash
#SBATCH --job-name=PINST-CELL-B-I-NPT
#SBATCH --account=s1000
#SBATCH --output=slurm.%J.out
#SBATCH --error=slurm.%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --time=1-00:00:00
#SBATCH --partition=normal
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=1,gpu

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

module unload daint-mc
module load daint-gpu
module load GSL/2.5-CrayCCE-19.10
source ~/.bashrc
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
ipi=/users/kvenkat/source/i-pi-vk/bin/i-pi
lmp=/users/kvenkat/source/lammps/src/lmp_serial
rm /tmp/ipi_*
HOST=$(hostname)
if [ -f "RESTART" ]; then
${ipi} RESTART > log.i-pi &
else
${ipi} input.xml > log.i-pi &
fi
sleep 30;
for x in {1..1}
do
${lmp} < in.lmp > /dev/null &
done
wait
