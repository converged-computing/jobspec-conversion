#!/bin/bash
#SBATCH --job-name=transfer1000tag
#SBATCH --output=transfer1000tag.out
#SBATCH --error=transfer1000tag.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=16GB
#SBATCH --qos=high

julia main.jl --lang sv --epochs 100 --trainSize 1000  \
              --dropouts 0.5 --mode 3 \
              --sourceModel ../checkpoints/bestModel.MorseModel_lemma_false_lang_UD-da_size_full_epoch10.jld2
julia main.jl --lang bg --epochs 100 --trainSize 1000 \
              --dropouts 0.5 --mode 3 \
              --sourceModel ../checkpoints/bestModel.MorseModel_lemma_false_lang_UD-ru_size_full_epoch10.jld2
julia main.jl --lang hu --epochs 100 --trainSize 1000 \
              --dropouts 0.5 --mode 3 \
              --sourceModel ../checkpoints/bestModel.MorseModel_lemma_false_lang_UD-fi_size_full_epoch10.jld2
julia main.jl --lang pt --epochs 100 --trainSize 1000 \
            --dropouts 0.5 --mode 3 \
            --sourceModel ../checkpoints/bestModel.MorseModel_lemma_false_lang_UD-es_size_full_epoch10.jld2
