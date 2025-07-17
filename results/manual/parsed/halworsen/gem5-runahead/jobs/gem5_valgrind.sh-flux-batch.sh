#!/bin/bash
#FLUX: --job-name=gem5-valgrind
#FLUX: -c=2
#FLUX: --queue=CPUQ
#FLUX: -t=21600
#FLUX: --urgency=16

RUNAHEAD_DIR="$HOME/gem5-runahead"
TEST_SCRIPT="$RUNAHEAD_DIR/gem5-extensions/configs/test/test_re.py"
LOG_DIR="$RUNAHEAD_DIR/jobs/testlogs"
if ! [[ -d "$LOG_DIR" ]]; then
    mkdir -p "$LOG_DIR"
fi
M5_OUT_DIR="$LOG_DIR/m5out-${SLURM_JOB_NAME}"
SIMOUT_FILE="$LOG_DIR/${SLURM_JOB_NAME}_simout.log"
SLURM_LOG_FILE="$LOG_DIR/${SLURM_JOB_NAME}_slurm.log"
exec &> $SLURM_LOG_FILE
echo "--- loading modules ---"
module --quiet purge
module restore gem5
module list
cd $RUNAHEAD_DIR
source venv/bin/activate
echo "--- python packages ---"
pip freeze
SIZE=$1
echo
echo "job: test run of gem5 (SE mode) - $SIZE x $SIZE matrix multiplication"
echo "time: $(date)"
echo "--- start job ---"
valgrind --leak-check=yes --track-origins=yes --suppressions=./gem5/util/valgrind-suppressions \
    ./gem5/build/X86/gem5.opt \
    --outdir $M5_OUT_DIR \
    $TEST_SCRIPT --size=$SIZE --random=1 \
    > $SIMOUT_FILE
