#!/bin/bash
#FLUX: --job-name=rfm_Sysinfo_job
#FLUX: -n=16
#FLUX: -t=600
#FLUX: --urgency=16

export FI_VERBS_IFACE='ib'

module load gcc/9.3.0-5abm3xg
module load intel-mpi/2019.7.217-bzs5ocr
export FI_VERBS_IFACE=ib
module load intel-mpi-benchmarks/2019.5-w54huiw
mpirun -np 16 python sysinfo.py
echo Done
cat *.info > all.info
