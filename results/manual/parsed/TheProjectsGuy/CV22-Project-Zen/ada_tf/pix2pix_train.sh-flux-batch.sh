#!/bin/bash
#FLUX: --job-name=p2p-s2m
#FLUX: -n=10
#FLUX: -t=129600
#FLUX: --urgency=16

echo "[BLOCK] ======= Inspecting node ======="
echo "Host: $HOSTNAME"
echo "Job ID: '$SLURM_JOB_ID'"
source $HOME/.bashrc    # Environment script
echo ""
echo "[BLOCK] ======= Loading data into the node ======="
scratch_dir="/scratch/$USER/$SLURM_JOB_ID"  # Unique for each job!
if [ ! -d $scratch_dir ]; then
    mkdir -p $scratch_dir
else
    echo "Folder '$scratch_dir' exists, contents are"
    tree -L 3 --filelimit=10 $scratch_dir
    # echo "Removing $scratch_dir"
    # rm -rf $scratch_dir
fi
data_zip_fn="cityscapes"    # File name with no extension
data_local_dir="/share1/$USER/datasets/$data_zip_fn.tar.gz"
if [ -f "$scratch_dir/`basename $data_local_dir`" ]; then
    echo "File $scratch_dir/`basename $data_local_dir` already exists"
else
    echo "File $scratch_dir/`basename $data_local_dir` not found, doing scp"
    scp $USER@ada:$data_local_dir $scratch_dir
    echo "Dataset moved to $HOSTNAME"
fi
echo ""
echo "[BLOCK] ======= Setting up node environment ======="
cd $scratch_dir
echo "[`pwd`] Unzipping `basename $data_local_dir`"
tar -xf "`basename $data_local_dir`"
echo "Unzip successful (pwd: `pwd`)"
tree --filelimit 8 -h -L 4 .
module load cuda/10.1
module load cudnn/7.6.5-cuda-10.2
module list
echo "Modules successfully loaded"
conda-init
conda activate tf-work-dev
echo "=== Running environment test script ==="
test_tf_cuda="$HOME/Tutorials/TensorFlow/test_cuda.py"
python $test_tf_cuda
echo ""
echo "[BLOCK] ======= Main training code ======="
out_dir="$scratch_dir/pix2pix_$SLURM_JOB_ID/"
data_dir="$scratch_dir"
data_seg="$data_zip_fn"
num_epochs=200
ckpt_freq=20
batch_size=10
disc_rf="70x70" # Discriminator Receptive Field
python ~/Pix2Pix/pix2pix_train_ada.py --data-dir=$data_dir \
    --data-seg=$data_seg --out-dir=$out_dir --num-epochs=$num_epochs \
    --batch-size=$batch_size --epoch-ckpt-freq=$ckpt_freq \
    --in-channels=3 --out-channels=3 --disc-receptive-field=$disc_rf \
    --lrsc-p=0.5
if [ ! -d $out_dir ]; then
    echo "[ERROR] Output directory '$out_dir' does not exist, no backup"
else
    # Make backup
    cd $out_dir
    echo "In `pwd` (saving everything here)"
    tar -cvf ./slurm_res_$SLURM_JOB_ID.tar ./ # Backup current dir
    echo "Archive created"
    ls -laR `pwd`
    # Transfer backup
    scp ./slurm_res_$SLURM_JOB_ID.tar $USER@ada:/share1/$USER
    echo "Backup transferred to '/share1/$USER'"
fi
echo ""
echo "[BLOCK] ======= End of script ======="
echo "Deleting $scratch_dir"
rm -rf $scratch_dir
echo "Script has ended"
