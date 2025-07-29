#!/bin/bash
#FLUX: --job-name=PINST-CELL-B-I-NPT
#FLUX: -c=12
#FLUX: --exclusive
#FLUX: --queue=normal
#FLUX: -t=86400
#FLUX: --urgency=16

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
