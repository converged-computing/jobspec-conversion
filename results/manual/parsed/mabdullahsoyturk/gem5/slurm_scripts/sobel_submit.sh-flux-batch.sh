#!/bin/bash
#FLUX: --job-name=sobel
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
python3 run.py --random --bench-name=sobel --sobel-input=/cta/users/masoyturk/FaultModel/gem5/tests/test-progs/sobel/figs/input.grey --sobel-output=/cta/users/masoyturk/FaultModel/gem5/tests/test-progs/sobel/golden.bin
RET=$?
echo "Job finished. Return code is $RET"
echo ""
