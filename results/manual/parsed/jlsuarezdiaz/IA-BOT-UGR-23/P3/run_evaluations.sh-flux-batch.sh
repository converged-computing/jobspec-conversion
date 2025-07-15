#!/bin/bash
#FLUX: --job-name=nerdy-animal-1149
#FLUX: --urgency=16

export PATH='/home/profesia/anaconda/condabin:$PATH'

folder=$1
ID=$2
EVAL=$3
mkdir softwares/"$folder"
cp -r ParchisIA-23-solved/* softwares/"$folder"
cp entregas/"$folder"/AIPlayer.cpp softwares/"$folder"/src
cp entregas/"$folder"/AIPlayer.h softwares/"$folder"/include
cd softwares/"$folder"
cmake -DCMAKE_BUILD_TYPE=Release .
make clean
make
export PATH="/home/profesia/anaconda/condabin:$PATH"
eval "$(conda shell.bash hook)"
conda activate IA
cp ../../../../../run_ninja_eval.sh .
cp ../../../../../run_tests_eval.py .
sbatch -J "1-1-$folder" run_ninja_eval.sh "$folder" $ID $EVAL 1 1
sbatch -J "2-1-$folder" run_ninja_eval.sh "$folder" $ID $EVAL 2 1
sbatch -J "1-2-$folder" run_ninja_eval.sh "$folder" $ID $EVAL 1 2
sbatch -J "2-2-$folder" run_ninja_eval.sh "$folder" $ID $EVAL 2 2
sbatch -J "1-3-$folder" run_ninja_eval.sh "$folder" $ID $EVAL 1 3
sbatch -J "2-3-$folder" run_ninja_eval.sh "$folder" $ID $EVAL 2 3
sbatch -J "1-4-$folder" run_ninja_eval.sh "$folder" $ID $EVAL 1 4
sbatch -J "2-4-$folder" run_ninja_eval.sh "$folder" $ID $EVAL 2 4
