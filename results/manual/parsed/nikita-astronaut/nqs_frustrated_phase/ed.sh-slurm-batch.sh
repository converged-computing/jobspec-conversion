#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --mem=200000
#SBATCH --time=3-00:00:00
#SBATCH --partition=dgx

conda activate tcm-test
pushd "/zfs/hybrilit.jinr.ru/user/a/astrakh/nqs_frustrated_phase/data/square/24/$1"
/zfs/hybrilit.jinr.ru/user/a/astrakh/HPhi.build/src/HPhi -e namelist.def 2>&1 | tee stdout.txt
popd
