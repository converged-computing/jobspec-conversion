#!/bin/bash
#FLUX: --job-name=butterscotch-underoos-7618
#FLUX: --queue=premium
#FLUX: -t=7200
#FLUX: --urgency=16

export PATH='${CONDA_ROOT}/bin:$PATH'
export MODPATH='`realpath .`'
export SHIFTER_IMAGE='ulissigroup/kubeflow_vasp:beef_vdw'

CONDA_ROOT="/global/homes/t/ttian20/.conda/envs/vpi"
GIT_REPO="ulissigroup/vasp-interactive"
if [ -z "$GIT_REF" ]
then
    GIT_REF="main"
fi
export PATH=${CONDA_ROOT}/bin:$PATH
uid=`uuidgen`
root=$SCRATCH/vpi-runner/$uid
mkdir -p $root && cd $root
jobid=${SLURM_JOB_ID}
echo "Job ID $jobid"
echo "Running tests under $root"
gh repo clone $GIT_REPO
cd vasp-interactive
git checkout $GIT_REF
echo "Check to $GIT_REF"
export MODPATH=`realpath .`
export SHIFTER_IMAGE=ulissigroup/kubeflow_vasp:beef_vdw
res="true"
for ver in "vasp.5.4.4.pl2" "vasp.6.3.0_pgi_mkl"
do
    echo "Testing VaspInteractive on $ver"
    for f in tests/test*.py
    do
        abs_f=`realpath $f`
        VASP_COMMAND="mpirun -np 32 --bind-to core /opt/${ver}/bin/vasp_std"
        shifter --image=$SHIFTER_IMAGE --env=VASP_COMMAND="$VASP_COMMAND" --env=PYTHONPATH="$MODPATH" --env=TEMPDIR="$SCRATCH" -- pytest -svv ${abs_f}
        # pytest -svv $f
        if [[ $? != 0 ]]
        then
            res="false"
            killall vasp_std
            break
        fi
        killall vasp_std
    done
    module unload vasp
    if [[ $res == "false" ]]
    then
        break
    fi
done
if [[ $res == "true" ]]
then
    echo "All test pass!"
else
    echo "Test fail. See output"
fi
gh workflow run cori_shifter_status.yaml -f signal=$res -f jobid=$jobid -f path=$root
