#!/bin/bash
#FLUX: --job-name=dinosaur-eagle-5096
#FLUX: -c=24
#FLUX: -t=87120
#FLUX: --urgency=16

module load python/3.9 cuda cudnn
source ~/torch/bin/activate
dataset_dir=~/projects/def-pfieguth/xREgoPose/xR-EgoPose/data/Dataset
declare -a a_test=("female_004_a_a"
				"female_008_a_a"
				"female_010_a_a"
				"female_012_a_a"
				"female_012_f_s"
				"male_001_a_a"
				"male_002_a_a"
				"male_004_f_s"
				"male_006_a_a"
				"male_007_f_s"
				"male_010_a_a"
				"male_014_f_s")
declare -a max_test=("i" "i" "i" "f" "a" "i" "j" "a" "i" "a" "i" "a")
declare -a a_train=("female_001_a_a"
				"female_002_a_a"
				"female_002_f_s"
				"female_003_a_a"
				"female_005_a_a"	
				"female_006_a_a"
				"female_007_a_a"
				"female_009_a_a"
				"female_011_a_a"
				"female_014_a_a"
				"female_015_a_a"
				"male_003_f_s"
				"male_004_a_a"
				"male_005_a_a"
				"male_006_f_s"
				"male_007_a_a"
				"male_008_f_s"
				"male_009_a_a"
				"male_010_f_s"
				"male_011_f_s"
				"male_014_a_a")
declare -a max_train=("i" "j" "a" "f" "i" "i" "h" "i" "f" "f" "j" "a" "i" "j" "a" "i" "a" "h" "a" "a" "i")
declare -a a_val=("male_008_a_a")
declare -a max_val=("i")
download_set () {
	case "$1" in
		ValSet)
			echo "ValSet"
			arr=("${a_val[@]}")
			max=("${max_val[@]}")
			;;
		TestSet)
			echo "TestSet"
			arr=("${a_test[@]}")
			max=("${max_test[@]}")
			;;
		TrainSet)
			echo "TrainSet"
			arr=("${a_train[@]}")
			max=("${max_train[@]}")
			;;
		*)
			break
			;;
	esac
	cd $1
	for i in "${!arr[@]}"
	do
		s=${arr[$i]}
		m=${max[$i]}
	mkdir -p $SLURM_TMPDIR/$1
        # extract data
        cat $s.tar.gz.part?? | unpigz -p 32  | tar -xvC $SLURM_TMPDIR/$1
   	done
	cd ..
}
set -e
mkdir -p ${dataset_dir}
cd ${dataset_dir}
download_set "TrainSet"
download_set "ValSet"
logdir=/home/s42hossa/projects/def-pfieguth/s42hossa/experiments/exp_3_branch_concat
tensorboard --logdir=${logdir} --host 0.0.0.0 --load_fast false & \
    python ~/projects/def-pfieguth/s42hossa/xREgoPose/train.py \
    --model xregopose_concat \
	--dataloader baseline \
    --logdir ${logdir} \
    --dataset_tr $SLURM_TMPDIR/TrainSet \
    --dataset_val $SLURM_TMPDIR/ValSet \
    --batch_size 16 \
    --epoch 20 \
    --num_workers 24 \
    --lr 0.001 \
    --es_patience 7 \
    --display_freq 64 \
    --val_freq 2000 \
    --encoder_type branch_concat \
    --load_resnet /home/s42hossa/projects/def-pfieguth/s42hossa/resnet101-63fe2227.pth
