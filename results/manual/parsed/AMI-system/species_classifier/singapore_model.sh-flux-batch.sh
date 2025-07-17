#!/bin/bash
#FLUX: --job-name=sticky-nunchucks-9330
#FLUX: -c=6
#FLUX: -t=36000
#FLUX: --urgency=16

module purge; module load baskerville
module load bask-apps/live
module load CUDA/11.7.0
module load Python/3.9.5-GCCcore-10.3.0
module load Miniconda3/4.10.3
eval "$(${EBROOTMINICONDA3}/bin/conda shell.bash hook)"
conda activate ~/amber/kg_conda_env2
generate_file_range() {
    local directory="/bask/homes/f/fspo1218/amber/data/gbif_singapore"
    local prefix="$1"  
    # Count the number of files matching the specified prefix in the directory
    local file_count=$(ls -1 "$directory"/"$prefix"/"$prefix"-500* 2>/dev/null | wc -l)
    ((file_count--))
    file_count=$(printf "%06d" "$file_count")
    formatted_url="$directory/$prefix/$prefix-500-{000000..$file_count}.tar"
    echo $formatted_url
}
train_url=$(generate_file_range "train")
test_url=$(generate_file_range "test")
val_url=$(generate_file_range "val")
echo 'Training the model'
python 04_train_model.py  \
    --train_webdataset_url "$train_url" \
    --val_webdataset_url "$val_url" \
    --test_webdataset_url "$test_url" \
    --config_file ./configs/01_singapore_data_config.json \
    --dataloader_num_workers 6 \
    --random_seed 42
echo $'\a'
