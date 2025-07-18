#!/bin/bash
#FLUX: --job-name=crusty-diablo-7929
#FLUX: -c=12
#FLUX: -t=259920
#FLUX: --urgency=16

module load StdEnv/2020 python/3.9 cuda cudnn
u=${u:-sebwood}
echo "User $u on shell $0"
SOURCEDIR=~/projects/def-franlp/$u/MemSE
cd ../..
echo "$SOURCEDIR"
echo "$PWD"
nvidia-smi
python3 -m venv $SLURM_TMPDIR/env
source $SLURM_TMPDIR/env/bin/activate
python -m pip install --no-index --upgrade pip setuptools
python -m pip install --no-index -r $SOURCEDIR/requirements.txt # --find-links "$SOURCEDIR"/experiments/paper/.installs/
datapath=$SLURM_TMPDIR/data
mkdir $datapath
TODAY=$(TZ=":America/Montreal" date)
COMMIT_ID=$(git rev-parse --verify HEAD)
echo "Experiment $SLURM_JOB_ID ($PWD) start $TODAY on node $SLURMD_NODENAME (git commit id $COMMIT_ID)"
python -m torch.utils.collect_env
datapath=$SLURM_TMPDIR/data
mkdir $datapath
dset=${dataset:-CIFAR10}
if [ "$dset" == "CIFAR10" ]; then
    echo "CIFAR10 selected"
    cp ~/projects/def-franlp/$u/data/cifar-10-python.tar.gz $datapath
    tar xzf $datapath/cifar-10-python.tar.gz -C $datapath
fi
line_to_read=$(($SLURM_ARRAY_TASK_ID+1))
echo "Line to read = $line_to_read"
SED_RES=$(sed -n "$line_to_read"p "$SOURCEDIR/experiments/paper/experiments.dat")
echo "${SED_RES} --datapath ${datapath}"
eval "${SED_RES} --datapath ${datapath}"
echo "Done"
