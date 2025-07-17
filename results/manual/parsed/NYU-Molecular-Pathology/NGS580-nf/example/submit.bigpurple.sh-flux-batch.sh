#!/bin/bash
#FLUX: --job-name=NGS580-run-2
#FLUX: -c=8
#FLUX: --queue=intellispace
#FLUX: -t=432000
#FLUX: --urgency=16

touch .nextflow.submitted
get_pid(){ head -1 .nextflow.pid; }
rm_submit(){ echo ">>> trap: rm_submit" ; [ -e .nextflow.submitted ] && rm -f .nextflow.submitted || : ; }
wait_pid(){ local pid=$1 ; while kill -0 $pid; do echo waiting for process $pid to end ; sleep 1 ; done ; }
nxf_kill(){ rm_submit ; echo ">>> trap: nxf_kill" && pid=$(get_pid) && kill $pid && wait_pid $pid ; }
trap nxf_kill HUP
trap nxf_kill INT
trap nxf_kill EXIT
make submit-bigpurple-run TIMESTAMP=1567000969 
