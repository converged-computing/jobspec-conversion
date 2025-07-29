#!/bin/bash
#SBATCH --job-name=neural1_bal_200each
#SBATCH --output=neural1_balanced_200each_1.test
#SBATCH --error=neural1_balanced_200each_1.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2000
#SBATCH --time=2-00:00:00
#SBATCH --partition=aspuru-guzik

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
