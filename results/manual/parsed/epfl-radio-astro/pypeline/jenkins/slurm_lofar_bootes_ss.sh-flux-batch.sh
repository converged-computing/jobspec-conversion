#!/bin/bash
#FLUX: --job-name=placid-cupcake-5227
#FLUX: --queue=build
#FLUX: -t=3600
#FLUX: --priority=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export OPENBLAS_NUM_THREADS='1'
export MKL_NUM_THREADS='1'
export VECLIB_MAXIMUM_THREADS='1'
export NUMEXPR_NUM_THREADS='1'

set -e
module load gcc
module load fftw
module load cuda/11.0
module list
CONDA_ENV=pype-111
eval "$(conda shell.bash hook)"
conda activate $CONDA_ENV
conda env list
PYTHON=`which python`
echo PYTHON = $PYTHON
python -V
pip show pypeline
echo; pwd
echo; hostname
echo
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export OPENBLAS_NUM_THREADS=1
export MKL_NUM_THREADS=1
export VECLIB_MAXIMUM_THREADS=1
export NUMEXPR_NUM_THREADS=1
echo; echo
env | grep UM_THREADS || true
echo
env | grep SLURM || true
echo; echo
echo "TEST_DIR    = ${TEST_DIR}"
echo "TEST_SEFF   = ${TEST_SEFF}"
echo
echo "PROFILE_CPROFILE = ${PROFILE_CPROFILE}"
echo "PROFILE_NSIGHT   = ${PROFILE_NSIGHT}"
echo "PROFILE_VTUNE    = ${PROFILE_VTUNE}"
echo "PROFILE_ADVISOR  = ${PROFILE_ADVISOR}"
EARLY_EXIT="${TEST_SEFF:-0}"
RUN_CPROFILE="${PROFILE_CPROFILE:-0}"
RUN_NSIGHT="${PROFILE_NSIGHT:-0}"
RUN_VTUNE="${PROFILE_VTUNE:-0}"
RUN_ADVISOR="${PROFILE_ADVISOR:-0}"
if [[ -z "${TEST_DIR}" ]]; then
    echo "Error: TEST_DIR unset. Must point to an existing directory."
    exit 1
else 
    if [[ ! -d "${TEST_DIR}" ]]; then
        echo "Error: TEST_DIR must point to an existing directory."
        exit 1
    fi
fi
ARG_TEST_DIR="--outdir ${TEST_DIR}"
PY_SCRIPT="./jenkins/lofar_bootes_ss.py"
echo "PY_SCRIPT = $PY_SCRIPT"; echo
echo "### Timing"
time python $PY_SCRIPT $ARG_TEST_DIR
echo; echo
if [ $EARLY_EXIT == "1" ]; then
    echo "TEST_SEFF set to 1 -> exit 0";
    exit 0
fi
if [ $RUN_CPROFILE == "1" ]; then
    echo "### cProfile"
    python -m cProfile -o $TEST_DIR/cProfile.out $PY_SCRIPT
    echo; echo
fi
if [ $RUN_VTUNE == "1" ]; then
    echo "### Intel VTune Amplifier"
    source /work/scitas-ge/richart/test_stacks/syrah/v1/opt/spack/linux-rhel7-skylake_avx512/gcc-8.4.0/intel-oneapi-vtune-2021.6.0-34ym22fgautykbgmg5hhgkiwrvbwfvko/setvars.sh || echo "ignoring warning"
    which vtune
    vtune -collect hotspots           -run-pass-thru=--no-altstack -strategy ldconfig:notrace:notrace -source-search-dir=. -search-dir=. -result-dir=$TEST_DIR/vtune_hs  -- $PYTHON $PY_SCRIPT
    vtune -collect hpc-performance    -run-pass-thru=--no-altstack -strategy ldconfig:notrace:notrace -source-search-dir=. -search-dir=. -result-dir=$TEST_DIR/vtune_hpc -- $PYTHON $PY_SCRIPT
    vtune -collect memory-consumption -run-pass-thru=--no-altstack -strategy ldconfig:notrace:notrace -source-search-dir=. -search-dir=. -result-dir=$TEST_DIR/vtune_mem -- $PYTHON $PY_SCRIPT
fi
echo; echo
if [ $RUN_ADVISOR == "1" ]; then
    echo "### Intel Advisor"
    source /work/scitas-ge/richart/test_stacks/syrah/v1/opt/spack/linux-rhel7-skylake_avx512/gcc-8.4.0/intel-oneapi-advisor-2021.4.0-any7cfov5s4ujprr7plf7ks7xzoyqljz/setvars.sh
    ADVIXE_RUNTOOL_OPTIONS=--no-altstack OMP_NUM_THREADS=1 advixe-cl -collect roofline --enable-cache-simulation --profile-python -project-dir $TEST_DIR/advisor -search-dir src:=. -- $PYTHON $PY_SCRIPT
fi
ls -rtl $TEST_DIR
