#!/bin/bash
#FLUX: --job-name=quirky-squidward-1001
#FLUX: --exclusive
#FLUX: --priority=16

. /vol/tcm01/westerhout_tom/conda/etc/profile.d/conda.sh
conda activate tcm-test
OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK:-$(nproc)}
HPHI="/vol/tcm01/westerhout_tom/HPhi/build/src/HPhi"
WORKDIR="workdir_${SLURM_JOB_ID:-0}"
J2=("0.1" "1.0")
for j2 in "${J2[@]}"; do
	python3 <<-EOF
from nqs_frustrated_phase import triangle
from nqs_frustrated_phase import hphi
hphi.write_settings(triangle.Triangle24, j2=$j2, workdir='$WORKDIR/j2=$j2')
EOF
done
for j2 in "${J2[@]}"; do
	pushd "$WORKDIR/j2=$j2"
	"$HPHI" -e namelist.def 2>&1 | tee stdout.txt
	popd
done
