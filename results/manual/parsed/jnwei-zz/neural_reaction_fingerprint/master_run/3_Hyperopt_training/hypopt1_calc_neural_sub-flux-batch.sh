#!/bin/bash
#FLUX: --job-name=pusheena-itch-1082
#FLUX: --urgency=16

scfolder="/scratch/$(date +%Y%m%d%H%M)_neural_bal_200each_1/"
curr=$(pwd)
shoes=1
mkdir -p  $scfolder
cp fp1_neural_hypopt_rxn_predict.py $scfolder 
cp fp1_reaction_estimator.py $scfolder
cp ~/reaction_learn/data/balanced_set/200each_class_3_2/balanced_200each_train_inputs_1.dat $scfolder/train_inputs.dat
cp ~/reaction_learn/data/balanced_set/200each_class_3_2/balanced_200each_train_targets.dat $scfolder/train_targets.dat
cd $scfolder
python -u fp1_neural_hypopt_rxn_predict.py > $curr/output/neural1_balanced_200each_train.out
cd
mkdir -p  $curr/output/
cp  $scfolder/neural*  $curr/output/
rm -r $scfolder
