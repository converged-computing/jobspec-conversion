#!/bin/bash
#FLUX: --job-name=2048_GPTJ6b_ecthr_a
#FLUX: -c=32
#FLUX: -t=72000
#FLUX: --urgency=16

module purge
module load cpuarch/amd
module load tensorflow-gpu/py3/2.11.0
set -x
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_a" \
            --layers_from_end 4 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/EleutherAI_gpt-j-6B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final_restart" \
            --pretrained_model 'EleutherAI/gpt-j-6B' \
            --finetuned_on_input_len 2048 \
            --to_test True \
            --to_train True \
            --train_run_number 1 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 2 \
            --dff 4096 \
            --with_clustering True \
            --pad_len 25 \
            --parent_dir "LEGAL-PE/Level-3_of_Framework/savedModels/2048_input_len/" \
            --train_dimR True \
            --save_dimR True \
            --train_clusterer True \
            --save_clusterer True \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/Extracted_data/from_2048input_ft_model/2048_input_len_100_overlap/J6b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_a" \
            --layers_from_end 4 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/EleutherAI_gpt-j-6B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final_restart" \
            --pretrained_model 'EleutherAI/gpt-j-6B' \
            --finetuned_on_input_len 2048 \
            --to_test True \
            --to_train True \
            --train_run_number 1 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 3 \
            --dff 4096 \
            --with_clustering True \
            --pad_len 25 \
            --parent_dir "LEGAL-PE/Level-3_of_Framework/savedModels/2048_input_len/" \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/Extracted_data/from_2048input_ft_model/2048_input_len_100_overlap/J6b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_a" \
            --layers_from_end 4 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/EleutherAI_gpt-j-6B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final_restart" \
            --pretrained_model 'EleutherAI/gpt-j-6B' \
            --finetuned_on_input_len 2048 \
            --to_test True \
            --to_train True \
            --train_run_number 1 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 1 \
            --dff 4096 \
            --with_clustering True \
            --pad_len 25 \
            --parent_dir "LEGAL-PE/Level-3_of_Framework/savedModels/2048_input_len/" \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/Extracted_data/from_2048input_ft_model/2048_input_len_100_overlap/J6b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_a" \
            --layers_from_end 4 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/EleutherAI_gpt-j-6B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final_restart" \
            --pretrained_model 'EleutherAI/gpt-j-6B' \
            --finetuned_on_input_len 2048 \
            --to_test True \
            --to_train True \
            --train_run_number 1 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 1 \
            --dff 4096 \
            --pad_len 25 \
            --parent_dir "LEGAL-PE/Level-3_of_Framework/savedModels/2048_input_len/" \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/Extracted_data/from_2048input_ft_model/2048_input_len_100_overlap/J6b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_a" \
            --layers_from_end 4 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/EleutherAI_gpt-j-6B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final_restart" \
            --pretrained_model 'EleutherAI/gpt-j-6B' \
            --finetuned_on_input_len 2048 \
            --to_test True \
            --to_train True \
            --train_run_number 1 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 2 \
            --dff 4096 \
            --pad_len 25 \
            --parent_dir "LEGAL-PE/Level-3_of_Framework/savedModels/2048_input_len/" \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/Extracted_data/from_2048input_ft_model/2048_input_len_100_overlap/J6b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_a" \
            --layers_from_end 4 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/EleutherAI_gpt-j-6B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final_restart" \
            --pretrained_model 'EleutherAI/gpt-j-6B' \
            --finetuned_on_input_len 2048 \
            --to_test True \
            --to_train True \
            --train_run_number 1 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 3 \
            --dff 4096 \
            --pad_len 25 \
            --parent_dir "LEGAL-PE/Level-3_of_Framework/savedModels/2048_input_len/" \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/Extracted_data/from_2048input_ft_model/2048_input_len_100_overlap/J6b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_a" \
            --layers_from_end 2 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/EleutherAI_gpt-j-6B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final_restart" \
            --pretrained_model 'EleutherAI/gpt-j-6B' \
            --finetuned_on_input_len 2048 \
            --to_test True \
            --to_train True \
            --train_run_number 1 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 1 \
            --dff 4096 \
            --pad_len 25 \
            --parent_dir "LEGAL-PE/Level-3_of_Framework/savedModels/2048_input_len/" \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/Extracted_data/from_2048input_ft_model/2048_input_len_100_overlap/J6b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_a" \
            --layers_from_end 2 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/EleutherAI_gpt-j-6B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final_restart" \
            --pretrained_model 'EleutherAI/gpt-j-6B' \
            --finetuned_on_input_len 2048 \
            --to_test True \
            --to_train True \
            --train_run_number 1 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 2 \
            --dff 4096 \
            --pad_len 25 \
            --parent_dir "LEGAL-PE/Level-3_of_Framework/savedModels/2048_input_len/" \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/Extracted_data/from_2048input_ft_model/2048_input_len_100_overlap/J6b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_a" \
            --layers_from_end 2 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/EleutherAI_gpt-j-6B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final_restart" \
            --pretrained_model 'EleutherAI/gpt-j-6B' \
            --finetuned_on_input_len 2048 \
            --to_test True \
            --to_train True \
            --train_run_number 1 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 3 \
            --dff 4096 \
            --pad_len 25 \
            --parent_dir "LEGAL-PE/Level-3_of_Framework/savedModels/2048_input_len/" \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/Extracted_data/from_2048input_ft_model/2048_input_len_100_overlap/J6b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_a" \
            --layers_from_end 2 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/EleutherAI_gpt-j-6B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final_restart" \
            --pretrained_model 'EleutherAI/gpt-j-6B' \
            --finetuned_on_input_len 2048 \
            --to_test True \
            --to_train True \
            --train_run_number 1 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 2 \
            --dff 4096 \
            --with_clustering True \
            --pad_len 25 \
            --parent_dir "LEGAL-PE/Level-3_of_Framework/savedModels/2048_input_len/" \
            --train_dimR True \
            --save_dimR True \
            --train_clusterer True \
            --save_clusterer True \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/Extracted_data/from_2048input_ft_model/2048_input_len_100_overlap/J6b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_a" \
            --layers_from_end 2 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/EleutherAI_gpt-j-6B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final_restart" \
            --pretrained_model 'EleutherAI/gpt-j-6B' \
            --finetuned_on_input_len 2048 \
            --to_test True \
            --to_train True \
            --train_run_number 1 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 3 \
            --dff 4096 \
            --with_clustering True \
            --pad_len 25 \
            --parent_dir "LEGAL-PE/Level-3_of_Framework/savedModels/2048_input_len/" \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/Extracted_data/from_2048input_ft_model/2048_input_len_100_overlap/J6b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_a" \
            --layers_from_end 2 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/EleutherAI_gpt-j-6B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final_restart" \
            --pretrained_model 'EleutherAI/gpt-j-6B' \
            --finetuned_on_input_len 2048 \
            --to_test True \
            --to_train True \
            --train_run_number 1 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 1 \
            --dff 4096 \
            --with_clustering True \
            --pad_len 25 \
            --parent_dir "LEGAL-PE/Level-3_of_Framework/savedModels/2048_input_len/" \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/Extracted_data/from_2048input_ft_model/2048_input_len_100_overlap/J6b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_a" \
            --layers_from_end 1 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/EleutherAI_gpt-j-6B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final_restart" \
            --pretrained_model 'EleutherAI/gpt-j-6B' \
            --finetuned_on_input_len 2048 \
            --to_test True \
            --to_train True \
            --train_run_number 1 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 1 \
            --dff 4096 \
            --pad_len 25 \
            --parent_dir "LEGAL-PE/Level-3_of_Framework/savedModels/2048_input_len/" \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/Extracted_data/from_2048input_ft_model/2048_input_len_100_overlap/J6b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_a" \
            --layers_from_end 1 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/EleutherAI_gpt-j-6B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final_restart" \
            --pretrained_model 'EleutherAI/gpt-j-6B' \
            --finetuned_on_input_len 2048 \
            --to_test True \
            --to_train True \
            --train_run_number 1 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 2 \
            --dff 4096 \
            --pad_len 25 \
            --parent_dir "LEGAL-PE/Level-3_of_Framework/savedModels/2048_input_len/" \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/Extracted_data/from_2048input_ft_model/2048_input_len_100_overlap/J6b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_a" \
            --layers_from_end 1 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/EleutherAI_gpt-j-6B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final_restart" \
            --pretrained_model 'EleutherAI/gpt-j-6B' \
            --finetuned_on_input_len 2048 \
            --to_test True \
            --to_train True \
            --train_run_number 1 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 3 \
            --dff 4096 \
            --pad_len 25 \
            --parent_dir "LEGAL-PE/Level-3_of_Framework/savedModels/2048_input_len/" \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/Extracted_data/from_2048input_ft_model/2048_input_len_100_overlap/J6b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_a" \
            --layers_from_end 1 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/EleutherAI_gpt-j-6B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final_restart" \
            --pretrained_model 'EleutherAI/gpt-j-6B' \
            --finetuned_on_input_len 2048 \
            --to_test True \
            --to_train True \
            --train_run_number 1 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 2 \
            --dff 4096 \
            --with_clustering True \
            --pad_len 25 \
            --parent_dir "LEGAL-PE/Level-3_of_Framework/savedModels/2048_input_len/" \
            --train_dimR True \
            --save_dimR True \
            --train_clusterer True \
            --save_clusterer True \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/Extracted_data/from_2048input_ft_model/2048_input_len_100_overlap/J6b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_a" \
            --layers_from_end 1 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/EleutherAI_gpt-j-6B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final_restart" \
            --pretrained_model 'EleutherAI/gpt-j-6B' \
            --finetuned_on_input_len 2048 \
            --to_test True \
            --to_train True \
            --train_run_number 1 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 3 \
            --dff 4096 \
            --with_clustering True \
            --pad_len 25 \
            --parent_dir "LEGAL-PE/Level-3_of_Framework/savedModels/2048_input_len/" \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/Extracted_data/from_2048input_ft_model/2048_input_len_100_overlap/J6b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_a" \
            --layers_from_end 1 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/EleutherAI_gpt-j-6B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final_restart" \
            --pretrained_model 'EleutherAI/gpt-j-6B' \
            --finetuned_on_input_len 2048 \
            --to_test True \
            --to_train True \
            --train_run_number 1 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 1 \
            --dff 4096 \
            --with_clustering True \
            --pad_len 25 \
            --parent_dir "LEGAL-PE/Level-3_of_Framework/savedModels/2048_input_len/" \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/Extracted_data/from_2048input_ft_model/2048_input_len_100_overlap/J6b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_a" \
            --add_layers True \
            --layers_from_end 4 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/EleutherAI_gpt-j-6B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final_restart" \
            --pretrained_model 'EleutherAI/gpt-j-6B' \
            --finetuned_on_input_len 2048 \
            --to_test True \
            --to_train True \
            --train_run_number 1 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 1 \
            --dff 4096 \
            --pad_len 25 \
            --parent_dir "LEGAL-PE/Level-3_of_Framework/savedModels/2048_input_len/" \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/Extracted_data/from_2048input_ft_model/2048_input_len_100_overlap/J6b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_a" \
            --add_layers True \
            --layers_from_end 4 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/EleutherAI_gpt-j-6B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final_restart" \
            --pretrained_model 'EleutherAI/gpt-j-6B' \
            --finetuned_on_input_len 2048 \
            --to_test True \
            --to_train True \
            --train_run_number 1 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 2 \
            --dff 4096 \
            --pad_len 25 \
            --parent_dir "LEGAL-PE/Level-3_of_Framework/savedModels/2048_input_len/" \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/Extracted_data/from_2048input_ft_model/2048_input_len_100_overlap/J6b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_a" \
            --add_layers True \
            --layers_from_end 4 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/EleutherAI_gpt-j-6B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final_restart" \
            --pretrained_model 'EleutherAI/gpt-j-6B' \
            --finetuned_on_input_len 2048 \
            --to_test True \
            --to_train True \
            --train_run_number 1 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 3 \
            --dff 4096 \
            --pad_len 25 \
            --parent_dir "LEGAL-PE/Level-3_of_Framework/savedModels/2048_input_len/" \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/Extracted_data/from_2048input_ft_model/2048_input_len_100_overlap/J6b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_a" \
            --add_layers True \
            --layers_from_end 4 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/EleutherAI_gpt-j-6B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final_restart" \
            --pretrained_model 'EleutherAI/gpt-j-6B' \
            --finetuned_on_input_len 2048 \
            --to_test True \
            --to_train True \
            --train_run_number 1 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 2 \
            --dff 4096 \
            --with_clustering True \
            --pad_len 25 \
            --parent_dir "LEGAL-PE/Level-3_of_Framework/savedModels/2048_input_len/" \
            --train_dimR True \
            --save_dimR True \
            --train_clusterer True \
            --save_clusterer True \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/Extracted_data/from_2048input_ft_model/2048_input_len_100_overlap/J6b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_a" \
            --add_layers True \
            --layers_from_end 4 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/EleutherAI_gpt-j-6B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final_restart" \
            --pretrained_model 'EleutherAI/gpt-j-6B' \
            --finetuned_on_input_len 2048 \
            --to_test True \
            --to_train True \
            --train_run_number 1 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 3 \
            --dff 4096 \
            --with_clustering True \
            --pad_len 25 \
            --parent_dir "LEGAL-PE/Level-3_of_Framework/savedModels/2048_input_len/" \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/Extracted_data/from_2048input_ft_model/2048_input_len_100_overlap/J6b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_a" \
            --add_layers True \
            --layers_from_end 4 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/EleutherAI_gpt-j-6B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final_restart" \
            --pretrained_model 'EleutherAI/gpt-j-6B' \
            --finetuned_on_input_len 2048 \
            --to_test True \
            --to_train True \
            --train_run_number 1 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 1 \
            --dff 4096 \
            --with_clustering True \
            --pad_len 25 \
            --parent_dir "LEGAL-PE/Level-3_of_Framework/savedModels/2048_input_len/" \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/Extracted_data/from_2048input_ft_model/2048_input_len_100_overlap/J6b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_a" \
            --add_layers True \
            --layers_from_end 2 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/EleutherAI_gpt-j-6B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final_restart" \
            --pretrained_model 'EleutherAI/gpt-j-6B' \
            --finetuned_on_input_len 2048 \
            --to_test True \
            --to_train True \
            --train_run_number 1 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 1 \
            --dff 4096 \
            --pad_len 25 \
            --parent_dir "LEGAL-PE/Level-3_of_Framework/savedModels/2048_input_len/" \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/Extracted_data/from_2048input_ft_model/2048_input_len_100_overlap/J6b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_a" \
            --add_layers True \
            --layers_from_end 2 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/EleutherAI_gpt-j-6B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final_restart" \
            --pretrained_model 'EleutherAI/gpt-j-6B' \
            --finetuned_on_input_len 2048 \
            --to_test True \
            --to_train True \
            --train_run_number 1 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 2 \
            --dff 4096 \
            --pad_len 25 \
            --parent_dir "LEGAL-PE/Level-3_of_Framework/savedModels/2048_input_len/" \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/Extracted_data/from_2048input_ft_model/2048_input_len_100_overlap/J6b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_a" \
            --add_layers True \
            --layers_from_end 2 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/EleutherAI_gpt-j-6B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final_restart" \
            --pretrained_model 'EleutherAI/gpt-j-6B' \
            --finetuned_on_input_len 2048 \
            --to_test True \
            --to_train True \
            --train_run_number 1 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 3 \
            --dff 4096 \
            --pad_len 25 \
            --parent_dir "LEGAL-PE/Level-3_of_Framework/savedModels/2048_input_len/" \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/Extracted_data/from_2048input_ft_model/2048_input_len_100_overlap/J6b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_a" \
            --add_layers True \
            --layers_from_end 2 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/EleutherAI_gpt-j-6B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final_restart" \
            --pretrained_model 'EleutherAI/gpt-j-6B' \
            --finetuned_on_input_len 2048 \
            --to_test True \
            --to_train True \
            --train_run_number 1 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 2 \
            --dff 4096 \
            --with_clustering True \
            --pad_len 25 \
            --parent_dir "LEGAL-PE/Level-3_of_Framework/savedModels/2048_input_len/" \
            --train_dimR True \
            --save_dimR True \
            --train_clusterer True \
            --save_clusterer True \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/Extracted_data/from_2048input_ft_model/2048_input_len_100_overlap/J6b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_a" \
            --add_layers True \
            --layers_from_end 2 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/EleutherAI_gpt-j-6B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final_restart" \
            --pretrained_model 'EleutherAI/gpt-j-6B' \
            --finetuned_on_input_len 2048 \
            --to_test True \
            --to_train True \
            --train_run_number 1 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 3 \
            --dff 4096 \
            --with_clustering True \
            --pad_len 25 \
            --parent_dir "LEGAL-PE/Level-3_of_Framework/savedModels/2048_input_len/" \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/Extracted_data/from_2048input_ft_model/2048_input_len_100_overlap/J6b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_a" \
            --add_layers True \
            --layers_from_end 2 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/EleutherAI_gpt-j-6B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final_restart" \
            --pretrained_model 'EleutherAI/gpt-j-6B' \
            --finetuned_on_input_len 2048 \
            --to_test True \
            --to_train True \
            --train_run_number 1 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 1 \
            --dff 4096 \
            --with_clustering True \
            --pad_len 25 \
            --parent_dir "LEGAL-PE/Level-3_of_Framework/savedModels/2048_input_len/" \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_a/Extracted_data/from_2048input_ft_model/2048_input_len_100_overlap/J6b/"
wait
