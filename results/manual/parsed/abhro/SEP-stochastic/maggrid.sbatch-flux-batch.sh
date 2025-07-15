#!/bin/bash
#FLUX: --job-name=loopy-cupcake-3617
#FLUX: -c=16
#FLUX: --queue=long
#FLUX: -t=10800
#FLUX: --urgency=16

export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK:-1}'

export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK:-1}
if [ "x$SHTC_FILE" == x ] || [ "x$MAGGRID_FILE" == x ]; then
  >&2 echo "Please set SHTC_FILE and MAGGRID_FILE"
  exit 1
fi
export SHTC_FILE MAGGRID_FILE
echo "Given parameters:"
echo "SHTC_FILE=$SHTC_FILE"
echo "MAGGRID_FILE=$MAGGRID_FILE"
ulimit -c unlimited
echo "Host information:"
echo "hostname: $(hostname)"
echo "hostname -A: $(hostname -A)"
echo "hostname -f: $(hostname -f)"
echo
echo "Running maggrid"
./maggrid
if [ $? == 139 ]; then # prev line seg faulted
  echo "Diagnostic info"
  set -v
  echo "Running on node $(hostname -f)"
  cat /proc/sys/kernel/core_pattern
  ls -lR /var/lib/apport
  exit 139
fi
