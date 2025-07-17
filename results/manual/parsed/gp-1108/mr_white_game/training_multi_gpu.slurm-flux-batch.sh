#!/bin/bash
#FLUX: --job-name=emb_train_multi_gpu
#FLUX: --queue=allgroups
#FLUX: -t=432000
#FLUX: --urgency=16

work_dir="/home/girottopie/Code/mr_white_game"
dataset_name="it_20M_lines_polished"
archive_path="/ext/${dataset_name}.tar.gz"
dataset_path="/ext/${dataset_name}.txt"
gdrive_id="1a6u6tUXCfswcV5AUOc5LC8hDE_ih4Yil"
rm $archive_path
rm $dataset_path
source /home/girottopie/.bashrc
gdrivedownload $gdrive_id $archive_path
cd /ext
tar -xzvf $dataset_name.tar.gz
echo "Extracted dataset, cheking first line:"
head -1 $dataset_path
echo ""
context_size=2
embedding_dim=300
epochs=10
batch_size=32
save_every=2
cd $work_dir
srun singularity exec --bind /ext:/ext --nv /nfsd/opt/sif-images/tensorflow_latest-gpu.sif python3 model_training/main_multi_gpu.py -d $dataset_path -c $context_size -e $embedding_dim -ep $epochs -b $batch_size -s $save_every
