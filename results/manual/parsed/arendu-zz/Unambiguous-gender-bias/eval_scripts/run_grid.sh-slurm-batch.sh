#!/bin/bash
#SBATCH --job-name=genderrun
#SBATCH --mail-user=adirendu@fb.com
#SBATCH --mail-type=fail
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=1
#SBATCH --mem=2048
#SBATCH --time=3-00:00:00
#SBATCH --partition=learnfair
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=1

set -e
module load anaconda3/5.0.1 cuda/10.1 cudnn/v7.6-cuda.10.0
source activate easyNMT
if [ $# -ne 3 ]; then
  echo 1>&2 "Usage: $0 tgt_lang model size"
  exit 3
fi
tgt=$1
model=$2
size=$3
proj=/checkpoint/adirendu/Unambiguous-gender-bias
echo 'rerun cmd:' sbatch run_grid.sh $tgt $model
src_file="$proj/generated/$size/source"
mkdir -p $proj/generated/$size/$model
tgt_file="$proj/generated/$size/$model/target"
cmd="python translate.py ${src_file}.en $tgt $model > ${tgt_file}.$tgt"
echo 'cmd:' $cmd
eval $cmd
cmd="python tag.py ${tgt_file}.$tgt $tgt"
echo 'cmd:' $cmd
eval $cmd
cmd="python align.py ${src_file}.en ${src_file}.ans ${tgt_file}.$tgt.tok ${tgt_file}.$tgt.tag $proj/grammars/occupation_list.txt"
echo 'cmd:' $cmd
eval $cmd
cmd="python score.py $proj/grammars/occupation_list.txt ${src_file}.en ${src_file}.ans ${tgt_file}.$tgt.tok.result > ${tgt_file}.$tgt.tok.scores"
echo 'cmd:' $cmd
eval $cmd
echo "done"
