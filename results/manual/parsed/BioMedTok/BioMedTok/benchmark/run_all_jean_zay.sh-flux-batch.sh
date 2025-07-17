#!/bin/bash
#FLUX: --job-name=BioMedTok
#FLUX: -c=6
#FLUX: --queue=gpu_p2
#FLUX: -t=7200
#FLUX: --urgency=16

module purge
module load pytorch-gpu/py3/1.12.1
JOBS=()
NBR_RUNS=4
declare -a MODELS=("BioMedTok/BPE-HF-NACHOS-FR-Morphemes" "BioMedTok/BPE-HF-PubMed-FR-Morphemes" "BioMedTok/BPE-HF-CC100-FR-Morphemes" "BioMedTok/BPE-HF-Wikipedia-FR-Morphemes" "BioMedTok/BPE-HF-NACHOS-FR" "BioMedTok/BPE-HF-PubMed-FR" "BioMedTok/BPE-HF-CC100-FR" "BioMedTok/BPE-HF-Wikipedia-FR" "BioMedTok/SentencePieceBPE-PubMed-FR-Morphemes" "BioMedTok/SentencePieceBPE-Wikipedia-FR-Morphemes" "BioMedTok/SentencePieceBPE-NACHOS-FR-Morphemes" "BioMedTok/SentencePieceBPE-CC100-FR-Morphemes" "BioMedTok/SentencePieceBPE-PubMed-FR" "BioMedTok/SentencePieceBPE-Wikipedia-FR" "BioMedTok/SentencePieceBPE-NACHOS-FR" "BioMedTok/SentencePieceBPE-CC100-FR")
declare -a PERCENTAGES=("1.0")
for fewshot in ${PERCENTAGES[@]}; do
    for MODEL_NAME in ${MODELS[@]}; do
        for ((i=0; i < $NBR_RUNS; i++)); do
            for f in ./recipes/*; do
                if [ -d "$f" ]; then
                    for filename in "$f"/scripts/*; do
                        dirPath=${filename%/*}/
                        filename=${filename##*/}
                        if [[ "$filename" == *".sh"* ]]; then
                            if [[ "$dirPath" == *"quaero"* ]]; then
                                for subset in 'emea' 'medline'; do
                                    JOBS+=("cd $dirPath && srun bash $filename '$MODEL_NAME' '$subset' '$fewshot'")
                                done 
                            elif [[ "$dirPath" == *"mantragsc"* ]]; then
                                for subset in 'fr_emea' 'fr_medline' 'fr_patents'; do
                                    JOBS+=("cd $dirPath && srun bash $filename '$MODEL_NAME' '$subset' '$fewshot'")
                                done
                            elif [[ "$dirPath" == *"e3c"* ]]; then
                                for subset in 'French_clinical' 'French_temporal'; do
                                    JOBS+=("cd $dirPath && srun bash $filename '$MODEL_NAME' '$subset' '$fewshot'")
                                done
                            else
                                JOBS+=("cd $dirPath && srun bash $filename '$MODEL_NAME' '$fewshot'")
                            fi
                        fi
                    done
                fi
            done
        done
    done
done
nvidia-smi
CURRENT=${SLURM_ARRAY_TASK_ID}
COMMAND=${JOBS[$CURRENT]}
echo "index: $CURRENT, value: ${COMMAND}"
eval $COMMAND
