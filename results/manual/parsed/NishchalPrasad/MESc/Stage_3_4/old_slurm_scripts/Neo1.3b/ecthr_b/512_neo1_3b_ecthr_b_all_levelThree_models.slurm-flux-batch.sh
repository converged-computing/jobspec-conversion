#!/bin/bash
#FLUX: --job-name=512_GPT-Neo_1.3b_ecthr_b
#FLUX: -c=32
#FLUX: -t=72000
#FLUX: --urgency=16

module purge
module load cpuarch/amd
module load tensorflow-gpu/py3/2.11.0
set -x
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_b" \
            --layers_from_end 4 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/EleutherAI_gpt-neo-1.3B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final" \
            --pretrained_model 'EleutherAI/gpt-neo-1.3B' \
            --to_test True \
            --to_train True \
            --train_run_number 1 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 1 \
            --dff 4096 \
            --pad_len 150 \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/Extracted_data/from_512input_ft_model/Neo1.3b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_b" \
            --layers_from_end 4 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/EleutherAI_gpt-neo-1.3B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final" \
            --pretrained_model 'EleutherAI/gpt-neo-1.3B' \
            --to_test True \
            --to_train True \
            --train_run_number 1 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 2 \
            --dff 4096 \
            --pad_len 150 \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/Extracted_data/from_512input_ft_model/Neo1.3b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_b" \
            --layers_from_end 4 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/EleutherAI_gpt-neo-1.3B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final" \
            --pretrained_model 'EleutherAI/gpt-neo-1.3B' \
            --to_test True \
            --to_train True \
            --train_run_number 1 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 3 \
            --dff 4096 \
            --pad_len 150 \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/Extracted_data/from_512input_ft_model/Neo1.3b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_b" \
            --layers_from_end 4 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/EleutherAI_gpt-neo-1.3B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final" \
            --pretrained_model 'EleutherAI/gpt-neo-1.3B' \
            --to_test True \
            --to_train True \
            --train_run_number 2 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 2 \
            --dff 4096 \
            --with_clustering True \
            --pad_len 150 \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/Extracted_data/from_512input_ft_model/Neo1.3b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_b" \
            --layers_from_end 4 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/EleutherAI_gpt-neo-1.3B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final" \
            --pretrained_model 'EleutherAI/gpt-neo-1.3B' \
            --to_test True \
            --to_train True \
            --train_run_number 1 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 3 \
            --dff 4096 \
            --with_clustering True \
            --pad_len 150 \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/Extracted_data/from_512input_ft_model/Neo1.3b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_b" \
            --layers_from_end 4 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/EleutherAI_gpt-neo-1.3B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final" \
            --pretrained_model 'EleutherAI/gpt-neo-1.3B' \
            --to_test True \
            --to_train True \
            --train_run_number 1 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 1 \
            --dff 4096 \
            --with_clustering True \
            --pad_len 150 \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/Extracted_data/from_512input_ft_model/Neo1.3b/"
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_b" \
            --layers_from_end 2 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/EleutherAI_gpt-neo-1.3B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final" \
            --pretrained_model 'EleutherAI/gpt-neo-1.3B' \
            --to_test True \
            --to_train True \
            --train_run_number 1 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 1 \
            --dff 4096 \
            --pad_len 150 \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/Extracted_data/from_512input_ft_model/Neo1.3b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_b" \
            --layers_from_end 2 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/EleutherAI_gpt-neo-1.3B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final" \
            --pretrained_model 'EleutherAI/gpt-neo-1.3B' \
            --to_test True \
            --to_train True \
            --train_run_number 1 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 2 \
            --dff 4096 \
            --pad_len 150 \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/Extracted_data/from_512input_ft_model/Neo1.3b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_b" \
            --layers_from_end 2 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/EleutherAI_gpt-neo-1.3B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final" \
            --pretrained_model 'EleutherAI/gpt-neo-1.3B' \
            --to_test True \
            --to_train True \
            --train_run_number 1 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 3 \
            --dff 4096 \
            --pad_len 150 \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/Extracted_data/from_512input_ft_model/Neo1.3b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_b" \
            --layers_from_end 2 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/EleutherAI_gpt-neo-1.3B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final" \
            --pretrained_model 'EleutherAI/gpt-neo-1.3B' \
            --to_test True \
            --to_train True \
            --train_run_number 2 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 2 \
            --dff 4096 \
            --with_clustering True \
            --pad_len 150 \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/Extracted_data/from_512input_ft_model/Neo1.3b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_b" \
            --layers_from_end 2 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/EleutherAI_gpt-neo-1.3B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final" \
            --pretrained_model 'EleutherAI/gpt-neo-1.3B' \
            --to_test True \
            --to_train True \
            --train_run_number 1 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 3 \
            --dff 4096 \
            --with_clustering True \
            --pad_len 150 \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/Extracted_data/from_512input_ft_model/Neo1.3b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_b" \
            --layers_from_end 2 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/EleutherAI_gpt-neo-1.3B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final" \
            --pretrained_model 'EleutherAI/gpt-neo-1.3B' \
            --to_test True \
            --to_train True \
            --train_run_number 1 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 1 \
            --dff 4096 \
            --with_clustering True \
            --pad_len 150 \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/Extracted_data/from_512input_ft_model/Neo1.3b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_b" \
            --layers_from_end 1 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/EleutherAI_gpt-neo-1.3B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final" \
            --pretrained_model 'EleutherAI/gpt-neo-1.3B' \
            --to_test True \
            --to_train True \
            --train_run_number 1 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 1 \
            --dff 4096 \
            --pad_len 150 \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/Extracted_data/from_512input_ft_model/Neo1.3b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_b" \
            --layers_from_end 1 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/EleutherAI_gpt-neo-1.3B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final" \
            --pretrained_model 'EleutherAI/gpt-neo-1.3B' \
            --to_test True \
            --to_train True \
            --train_run_number 1 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 2 \
            --dff 4096 \
            --pad_len 150 \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/Extracted_data/from_512input_ft_model/Neo1.3b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_b" \
            --layers_from_end 1 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/EleutherAI_gpt-neo-1.3B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final" \
            --pretrained_model 'EleutherAI/gpt-neo-1.3B' \
            --to_test True \
            --to_train True \
            --train_run_number 1 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 3 \
            --dff 4096 \
            --pad_len 150 \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/Extracted_data/from_512input_ft_model/Neo1.3b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_b" \
            --layers_from_end 1 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/EleutherAI_gpt-neo-1.3B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final" \
            --pretrained_model 'EleutherAI/gpt-neo-1.3B' \
            --to_test True \
            --to_train True \
            --train_run_number 2 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 2 \
            --dff 4096 \
            --with_clustering True \
            --pad_len 150 \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/Extracted_data/from_512input_ft_model/Neo1.3b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_b" \
            --layers_from_end 1 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/EleutherAI_gpt-neo-1.3B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final" \
            --pretrained_model 'EleutherAI/gpt-neo-1.3B' \
            --to_test True \
            --to_train True \
            --train_run_number 1 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 3 \
            --dff 4096 \
            --with_clustering True \
            --pad_len 150 \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/Extracted_data/from_512input_ft_model/Neo1.3b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_b" \
            --layers_from_end 1 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/EleutherAI_gpt-neo-1.3B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final" \
            --pretrained_model 'EleutherAI/gpt-neo-1.3B' \
            --to_test True \
            --to_train True \
            --train_run_number 1 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 1 \
            --dff 4096 \
            --with_clustering True \
            --pad_len 150 \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/Extracted_data/from_512input_ft_model/Neo1.3b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_b" \
            --add_layers True \
            --layers_from_end 4 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/EleutherAI_gpt-neo-1.3B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final" \
            --pretrained_model 'EleutherAI/gpt-neo-1.3B' \
            --to_test True \
            --to_train True \
            --train_run_number 1 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 1 \
            --dff 4096 \
            --pad_len 150 \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/Extracted_data/from_512input_ft_model/Neo1.3b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_b" \
            --add_layers True \
            --layers_from_end 4 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/EleutherAI_gpt-neo-1.3B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final" \
            --pretrained_model 'EleutherAI/gpt-neo-1.3B' \
            --to_test True \
            --to_train True \
            --train_run_number 1 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 2 \
            --dff 4096 \
            --pad_len 150 \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/Extracted_data/from_512input_ft_model/Neo1.3b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_b" \
            --add_layers True \
            --layers_from_end 4 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/EleutherAI_gpt-neo-1.3B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final" \
            --pretrained_model 'EleutherAI/gpt-neo-1.3B' \
            --to_test True \
            --to_train True \
            --train_run_number 1 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 3 \
            --dff 4096 \
            --pad_len 150 \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/Extracted_data/from_512input_ft_model/Neo1.3b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_b" \
            --add_layers True \
            --layers_from_end 4 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/EleutherAI_gpt-neo-1.3B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final" \
            --pretrained_model 'EleutherAI/gpt-neo-1.3B' \
            --to_test True \
            --to_train True \
            --train_run_number 2 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 2 \
            --dff 4096 \
            --with_clustering True \
            --pad_len 150 \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/Extracted_data/from_512input_ft_model/Neo1.3b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_b" \
            --add_layers True \
            --layers_from_end 4 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/EleutherAI_gpt-neo-1.3B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final" \
            --pretrained_model 'EleutherAI/gpt-neo-1.3B' \
            --to_test True \
            --to_train True \
            --train_run_number 1 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 3 \
            --dff 4096 \
            --with_clustering True \
            --pad_len 150 \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/Extracted_data/from_512input_ft_model/Neo1.3b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_b" \
            --add_layers True \
            --layers_from_end 4 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/EleutherAI_gpt-neo-1.3B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final" \
            --pretrained_model 'EleutherAI/gpt-neo-1.3B' \
            --to_test True \
            --to_train True \
            --train_run_number 1 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 1 \
            --dff 4096 \
            --with_clustering True \
            --pad_len 150 \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/Extracted_data/from_512input_ft_model/Neo1.3b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_b" \
            --add_layers True \
            --layers_from_end 2 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/EleutherAI_gpt-neo-1.3B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final" \
            --pretrained_model 'EleutherAI/gpt-neo-1.3B' \
            --to_test True \
            --to_train True \
            --train_run_number 1 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 1 \
            --dff 4096 \
            --pad_len 150 \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/Extracted_data/from_512input_ft_model/Neo1.3b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_b" \
            --add_layers True \
            --layers_from_end 2 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/EleutherAI_gpt-neo-1.3B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final" \
            --pretrained_model 'EleutherAI/gpt-neo-1.3B' \
            --to_test True \
            --to_train True \
            --train_run_number 1 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 2 \
            --dff 4096 \
            --pad_len 150 \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/Extracted_data/from_512input_ft_model/Neo1.3b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_b" \
            --add_layers True \
            --layers_from_end 2 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/EleutherAI_gpt-neo-1.3B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final" \
            --pretrained_model 'EleutherAI/gpt-neo-1.3B' \
            --to_test True \
            --to_train True \
            --train_run_number 1 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 3 \
            --dff 4096 \
            --pad_len 150 \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/Extracted_data/from_512input_ft_model/Neo1.3b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_b" \
            --add_layers True \
            --layers_from_end 2 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/EleutherAI_gpt-neo-1.3B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final" \
            --pretrained_model 'EleutherAI/gpt-neo-1.3B' \
            --to_test True \
            --to_train True \
            --train_run_number 2 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 2 \
            --dff 4096 \
            --with_clustering True \
            --pad_len 150 \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/Extracted_data/from_512input_ft_model/Neo1.3b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_b" \
            --add_layers True \
            --layers_from_end 2 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/EleutherAI_gpt-neo-1.3B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final" \
            --pretrained_model 'EleutherAI/gpt-neo-1.3B' \
            --to_test True \
            --to_train True \
            --train_run_number 1 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 3 \
            --dff 4096 \
            --with_clustering True \
            --pad_len 150 \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/Extracted_data/from_512input_ft_model/Neo1.3b/"
wait
python LEGAL-PE/Level-3_of_Framework/Level_three/training_models-DimRed+Clustering.py \
            --dataset_subset "ecthr_b" \
            --add_layers True \
            --layers_from_end 2 \
            --ft_model_used_for_extraction "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/EleutherAI_gpt-neo-1.3B/Strategy_0/sub_strategy_0/ZeRO3_epoch_2__final" \
            --pretrained_model 'EleutherAI/gpt-neo-1.3B' \
            --to_test True \
            --to_train True \
            --train_run_number 1 \
            --verbose 2 \
            --epochs 5 \
            --num_layers 1 \
            --dff 4096 \
            --with_clustering True \
            --pad_len 150 \
            --data_path "LEGAL-P_E/SIGIR_experiments/finetuned_models/ecthr_b/Extracted_data/from_512input_ft_model/Neo1.3b/"
wait
