#!/bin/bash
#FLUX: --job-name=frigid-pedo-5506
#FLUX: -c=32
#FLUX: -t=259800
#FLUX: --urgency=16

export HF_DATASETS_OFFLINE='1'

module load StdEnv/2020 python/3.10 cuda cudnn gcc/9.3.0 arrow
echo "User $USER on shell $0"
SOURCEDIR=~/projects/def-franlp/$USER/Samson
cd $SOURCEDIR
nvidia-smi
cp ~/projects/def-franlp/$USER/venv.tar.gz $SLURM_TMPDIR
tar xzf $SLURM_TMPDIR/venv.tar.gz -C $SLURM_TMPDIR
source $SLURM_TMPDIR/.venv/bin/activate
TODAY=$(TZ=":America/Montreal" date)
COMMIT_ID=$(git rev-parse --verify HEAD)
echo "Experiment $SLURM_JOB_ID ($PWD) start $TODAY on node $SLURMD_NODENAME (git commit id $COMMIT_ID)"
python -m torch.utils.collect_env
DATASET_STORE='/home/sebwood/projects/def-franlp/sebwood/datasets'
datapath=$SLURM_TMPDIR/data
echo $datapath
mkdir $datapath
cp -r $DATASET_STORE/prepared_hf/imagenet1k.hfdatasets $datapath
ls $datapath
export HF_DATASETS_OFFLINE=1
SED_RES=$(sed -n "$SLURM_ARRAY_TASK_ID"p "$SOURCEDIR/experiments.dat")
eval "python main.py ${SED_RES} --datapath ${datapath}"
echo "Done"
