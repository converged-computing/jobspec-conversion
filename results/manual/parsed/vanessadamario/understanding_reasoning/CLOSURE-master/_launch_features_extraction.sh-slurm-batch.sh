#!/bin/bash
#SBATCH --job-name=extract_feats
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:titan-x:1
#SBATCH --mem=10GB
#SBATCH --time=01:00:00
#SBATCH --array=0

module add clustername/singularity/3.4.1
hostname
echo $CUDA_VISIBLE_DEVICES
echo $CUDA_DEVICE_ORDER
cd path_to_folder/understanding_reasoning/CLOSURE-master
declare -a StringArray=("and_mat_spa_val.json" "compare_mat_spa_val.json" "compare_mat_val.json" "embed_mat_spa_val.json" "embed_spa_mat_val.json" "or_mat_spa_val.json")
for val in "${StringArray[@]}"
do
  echo $val
  singularity exec -B /om2:/om2 --nv singularity_path python3 \
  ./scripts/preprocess_questions.py \
  --input_questions_json path_to_folder/understanding_reasoning/CLOSURE-master/closure_2/${val} # dataset/CLOSURE/$val \
  --output_h5_file path_to_folder/understanding_reasoning/CLOSURE-master/closure_2/${val}_val_questions.h5 # dataset/CLOSURE/${val}_val_questions.h5 \
  --output_vocab_json path_to_folder/understanding_reasoning/CLOSURE-master/closure_2/vocab.json
done
