#!/bin/bash
#FLUX: --job-name=c192_pace_driver
#FLUX: -n=6
#FLUX: --queue=normal
#FLUX: -t=2700
#FLUX: --urgency=16

export VIRTUALENV='${PACE_DIR}/venv'
export OMP_NUM_THREADS='12'
export FV3_DACEMODE='BuildAndRun'

JENKINS_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
PACE_DIR=$JENKINS_DIR/../
export VIRTUALENV=${PACE_DIR}/venv
${JENKINS_DIR}/install_virtualenv.sh ${VIRTUALENV}
source ${VIRTUALENV}/bin/activate
BUILDENV_DIR=$PACE_DIR/buildenv
. ${BUILDENV_DIR}/schedulerTools.sh
mkdir -p ${PACE_DIR}/test_perf
cd $PACE_DIR/test_perf
cat << EOF > run.daint.slurm
set -x
export OMP_NUM_THREADS=12
export FV3_DACEMODE=BuildAndRun
srun python -m pace.run ${JENKINS_DIR}/driver_configs/baroclinic_c192_6ranks.yaml
EOF
launch_job run.daint.slurm 3600
python ${JENKINS_DIR}/print_performance_number.py
cp *.json driver.out /project/s1053/performance/fv3core_performance/dace_gpu
