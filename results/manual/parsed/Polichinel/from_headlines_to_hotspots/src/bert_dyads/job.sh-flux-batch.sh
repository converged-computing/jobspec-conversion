#!/bin/bash
#FLUX: --job-name=bloated-arm-1911
#FLUX: --urgency=16

input_file=$1  # opting to also take the file as an input argument
eval `head -n $SLURM_ARRAY_TASK_ID $input_file | tail -1`
module load PyTorch/1.12.1-foss-2022a-CUDA-11.7.0 SciPy-bundle/2022.05-foss-2022a  IPython scikit-learn/1.1.2-foss-2022a matplotlib/3.5.2-foss-2022a
source /cephyr/users/croicu/Alvis/marisol/bin/activate
echo "[`date`] Running hfmodel=$hf_model  seed=$seed"
python -u bertworks.py --seed=$seed --huggingface_name=$hf_model
