#!/bin/bash
#FLUX: --job-name=strawberry-hope-7994
#FLUX: -c=4
#FLUX: --gpus-per-task=1
#FLUX: -t=86400
#FLUX: --urgency=16

export PYTHONPATH='$OUT/rtg.zip'

RTG_PATH=~/repos/rtg
source ~/.bashrc
CONDA_ENV=rtg     # empty means don't activate environment
usage() {
    echo "Usage: $0 -d <exp/dir>
    [-r RTG_PATH (default: $RTG_PATH)]
    [-u update the code, get the latest from $RTG_PATH]
    [-e conda_env  default:$CONDA_ENV (empty string disables activation)] " 1>&2;
    exit 1;
}
while getopts ":ud:c:e:p:r:" o; do
    case "${o}" in
        d) OUT=${OPTARG} ;;
        e) CONDA_ENV=${OPTARG} ;;
        u) UPDATE=YES ;;
        r) RTG_PATH=${OPTARG} ;;
        *) usage ;;
    esac
done
[[ -n $OUT ]] || usage   # show usage and exit
echo "Output dir = $OUT"
[[ -d $OUT ]] || mkdir -p $OUT
OUT=`realpath $OUT`
if [[ ! -f $OUT/rtg.zip  || -n $UPDATE ]]; then
    [[ -f $RTG_PATH/rtg/__init__.py ]] || { echo "Error: RTG_PATH=$RTG_PATH is not valid"; exit 2; }
    echo "Zipping source code from $RTG_PATH to $OUT/rtg.zip"
    OLD_DIR=$PWD
    cd ${RTG_PATH}
    zip -r $OUT/rtg.zip rtg -x "*__pycache__*"
    #[[ -e $OUT/scripts ]] || ln -s ${PWD}/scripts $OUT/scripts  # scripts are needed
    git rev-parse HEAD > $OUT/githead   # git commit message
    cd $OLD_DIR
fi
if [[ -n ${CONDA_ENV} ]]; then
    echo "Activating environment $CONDA_ENV"
    source activate ${CONDA_ENV} || { echo "Unable to activate $CONDA_ENV" ; exit 3; }
fi
export PYTHONPATH=$OUT/rtg.zip
[[ -f $OUT/job.sh.bak ]] && rm $OUT/job.sh.bak
cp "${BASH_SOURCE[0]}"  $OUT/job.sh.bak
echo  "`date`: Starting pipeline... $OUT"
cmd="python -m rtg.pipeline $OUT --gpu-only"
echo "command::: $cmd"
if eval ${cmd}; then
    echo "`date` :: Done"
else
    echo "Error: exit status=$?"
fi
