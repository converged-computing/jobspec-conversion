#!/bin/bash
#SBATCH --job-name=c192_pace_driver
#SBATCH --account=go31
#SBATCH --output=driver.out
#SBATCH --nodes=1
#SBATCH --ntasks=6
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=00:45:00
#SBATCH --partition=normal
#SBATCH --constraint=gpu,ntasks-per-node=1

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
