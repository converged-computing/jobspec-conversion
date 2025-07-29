#!/bin/bash
#FLUX: --job-name=gfn
#FLUX: -c=8
#FLUX: --queue=long
#FLUX: --urgency=16

echo "Arg 0: $0"
echo "Arg 1: $1"
argshydra=$(echo $@ | cut -d " " -f1 --complement)
echo "Hydra arguments: $argshydra"
rsync -av --relative "$1" $SLURM_TMPDIR --exclude ".git"
cd $SLURM_TMPDIR/"$1"
sh setup_gflownet.sh $SLURM_TMPDIR/venv
echo "Currently using:"
echo $(which python)
echo "in:"
echo $(pwd)
echo "sbatch file name: $0"
python main.py $argshydra
