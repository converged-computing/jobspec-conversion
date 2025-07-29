#!/bin/bash
#FLUX: --job-name=PINST-CELL-0-B-II-new-QTI-8
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
ipimf=/users/kvenkat/s1000/mol-fluctuations/i-pi/bin/i-pi
lmp=/users/kvenkat/source/lammps/src/lmp_serial
rm /tmp/ipi_*
HOST=$(hostname)
if [ -f "RESTART" ]; then
${ipimf} RESTART > log.i-pi &
else
${ipimf} input.xml > log.i-pi &
fi
sleep 30;
for x in {1..16}
do
${lmp} < in-1.lmp > /dev/null &
${lmp} < in-2.lmp > /dev/null &
done
wait
