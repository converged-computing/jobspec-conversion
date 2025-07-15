#!/bin/bash
#FLUX: --job-name=montecarlo
#FLUX: -n=18
#FLUX: --queue=short
#FLUX: -t=86400
#FLUX: --urgency=16

INPUT_FILE=""
source /etc/profile.d/zzz_cta.sh
echo "source /etc/profile.d/zzz_cta.sh"
echo ""
echo "======================================================================================"
env
echo "======================================================================================"
echo ""
echo "======================================================================================"
echo "Setting stack size to unlimited..."
ulimit -s unlimited
ulimit -l unlimited
ulimit -a
echo
echo "======================================================================================"
echo "Running..."
echo "======================================================================================"
echo "Starting new Job"
python3 run.py --random --bench-name=monteCarlo --bench-name=monteCarlo --monte-x=4 --monte-y=4 --monte-walks=4 --monte-tasks=4 --monte-output=/cta/users/masoyturk/FaultModel/gem5/tests/test-progs/monteCarlo/golden.bin
RET=$?
echo "Job finished. Return code is $RET"
echo ""
