#!/bin/bash
#FLUX: --job-name=dirty-general-1349
#FLUX: --urgency=16

module purge
module load singularity
port=$(echo "49152+$(echo ${SLURM_JOBID} | tail -c 4)" | bc)
isfree=$(netstat -taln | grep $port)
while [[ -n "$isfree" ]]; do
  port=$[port+1]
  isfree=$(netstat -taln | grep $port)
done
singularity exec /hpc/classes/msds/hpc/dask.simg jupyter-lab --no-browser --ip=127.0.0.1 --port=${port} &
sleep 1m
cat << EOF
OpenSSH:
  1. Open new terminal.
  2. Copy and paste into terminal (without quotes):
     "ssh -C -J m2.smu.edu -L ${port}:localhost:${port} ${USER}@${HOSTNAME}"
  3. Open URL above in browser.
EOF
wait
