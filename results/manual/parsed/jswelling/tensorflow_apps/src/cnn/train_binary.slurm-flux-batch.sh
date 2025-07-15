#!/bin/bash
#FLUX: --job-name=fat-nalgas-8437
#FLUX: --urgency=16

export PYTHONPATH='/pylon5/pscstaff/welling/git/tensorflow_apps/src:$PYTHONPATH'
export LD_PRELOAD='/usr/lib64/libtcmalloc_minimal.so.4'

myname=`whoami`
groupid=syr54jp
WORK=/pylon5/${groupid}/${myname}
srcdir=/pylon5/pscstaff/welling/git/tensorflow_apps/src/cnn
datadir=/pylon5/pscstaff/welling/pylon2_rescue/fish_cube_links
file_list=${datadir}/../fish_cube_files_train_2.txt
nepochs=100
nexamples=`cat $file_list | wc -l`
module load anaconda3
source activate /pylon5/pscstaff/welling/conda/envs/tfEnv
cd $srcdir
export PYTHONPATH=/pylon5/pscstaff/welling/git/tensorflow_apps/src:$PYTHONPATH
export LD_PRELOAD="/usr/lib64/libtcmalloc_minimal.so.4"
python ./train_binaryclassifier.py \
       --network_pattern two_layers_logits_to_binary \
       --batch_size 180 \
       --read_threads 3 \
       --data_dir $datadir \
       --file_list $file_list \
       --log_dir $WORK/tf/logs/cnn_train_${SLURM_JOB_ID} \
       --num_epochs $nepochs \
       --shuffle_size $nexamples \
       --num_examples $nexamples \
       --learning_rate 0.1 \
       --starting_snapshot $WORK/tf/logs/cnn_train_6045675cnn-4404 \
       --snapshot_load cnn,classifier \
       --random_rotation
