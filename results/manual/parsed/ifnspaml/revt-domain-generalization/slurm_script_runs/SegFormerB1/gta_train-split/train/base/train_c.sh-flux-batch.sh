#!/bin/bash
#FLUX: --job-name=segformer_b1_gta_train-split_base_train_c
#FLUX: -c=2
#FLUX: --queue=gpu,gpub
#FLUX: -t=604800
#FLUX: --urgency=16

max_iters=40000
main_config="./local_configs/segformer/B1/segformer.b1.512x512.gta2cs.40k.batch2_base.py"
work_dir_prefix="./work_dirs/gta_train/segformer_b1/segformer.b1.512x512.gta2cs.40k.batch2_base"
num_models=1
work_dir_start_char="c"
start_seed=2
train_dataset="gta_train"
test_models=true
test_cityscapes=true
test_cityscapes_val=true
test_bdd=true
test_mapillary=true
test_acdc=true
test_kitti=true
test_synthia=true
test_gta_val=true
test_synthia_val=true
override=false
module load comp/gcc/11.2.0
source activate transformer-domain-generalization
nvidia-smi
echo -e "Node: $(hostname)"
echo -e "Job internal GPU id(s): $CUDA_VISIBLE_DEVICES"
echo -e "Job external GPU id(s): ${SLURM_JOB_GPUS}"
declare -a work_dirs=()
declare -a seeds=()
suffix=$(printf '%x\n' "'$work_dir_start_char")
echo -e "Names of the work_dirs:"
for (( i=0; i<num_models; i++ ))
do
    letter=$(echo "$((suffix + i))" | xxd -p -r)
    work_dirs+=("${work_dir_prefix}_${letter}")
    seeds+=($((start_seed + i)))
    echo -e "   ${work_dirs[i]}"
done
data_train_split=""
if [ "$train_dataset" = "gta_full" ]; then
    data_train_type="GTADataset"
    data_train_data_root="data/gta/"
    data_train_img_dir="images"
    data_train_ann_dir="labels"
    echo -e "Train Dataset:\n   GTA Full (Train+Val)"
elif [ "$train_dataset" = "gta_train" ]; then
    data_train_type="GTADataset"
    data_train_data_root="data/"
    data_train_img_dir="gta/images"
    data_train_ann_dir="gta/labels"
    data_train_split="data.train.split=\"gta_splits/train_split.txt\""
    echo -e "Train Dataset:\n   GTA Train"
elif [ "$train_dataset" = "synthia_train" ]; then
    data_train_type="SynthiaDataset"
    data_train_data_root="data/"
    data_train_img_dir="synthia/RGB"
    data_train_ann_dir="synthia/GT/LABELS/LABELS"
    data_train_split="data.train.split=\"synthia_splits/train_split.txt\""
    echo -e "Train Dataset:\n   Synthia"
else ## "synthia_full"
    data_train_type="SynthiaDataset"
    data_train_data_root="data/synthia/"
    data_train_img_dir="RGB"
    data_train_ann_dir="GT/LABELS/LABELS"
    echo -e "Train Dataset:\n   Synthia"
fi
declare -a dataset_names=()
declare -a dataset_types=()
declare -a dataset_data_root=()
declare -a dataset_img_dir=()
declare -a dataset_ann_dir=()
declare -a data_test_split=()
if [ "$test_cityscapes" = true ] ; then
    dataset_names+=("Cityscapes")
    dataset_types+=("CityscapesDataset")
    dataset_data_root+=("data/cityscapes/")
    dataset_img_dir+=("leftImg8bit/val")
    dataset_ann_dir+=("gtFine/val")
    data_test_split+=("")
fi
if [ "$test_cityscapes_val" = true ] ; then
    dataset_names+=("Cityscapes_val")
    dataset_types+=("CityscapesDataset")
    dataset_data_root+=("data/")
    dataset_img_dir+=("cityscapes/leftImg8bit/train")
    dataset_ann_dir+=("cityscapes/gtFine/train")
    data_test_split+=("data.test.split=\"cs_splits/val_split.txt\"")
fi
if [ "$test_bdd" = true ] ; then
    dataset_names+=("bdd")
    dataset_types+=("BDD100kDataset")
    dataset_data_root+=("data/bdd100k/")
    dataset_img_dir+=("images/val")
    dataset_ann_dir+=("labels/val")
    data_test_split+=("")
fi
if [ "$test_mapillary" = true ] ; then
    dataset_names+=("mapillary")
    dataset_types+=("MapillaryDataset")
    dataset_data_root+=("data/mapillary/")
    dataset_img_dir+=("validation/ColorImage")
    dataset_ann_dir+=("segmentation_trainid/validation/Segmentation")
    data_test_split+=("")
fi
if [ "$test_acdc" = true ] ; then
    dataset_names+=("acdc")
    dataset_types+=("ACDCDataset")
    dataset_data_root+=("data/acdc/")
    dataset_img_dir+=("rgb_anon/val")
    dataset_ann_dir+=("gt/val")
    data_test_split+=("")
fi
if [ "$test_kitti" = true ] ; then
    dataset_names+=("kitti")
    dataset_types+=("KITTI2015Dataset")
    dataset_data_root+=("data/kitti/")
    dataset_img_dir+=("images/validation")
    dataset_ann_dir+=("labels/validation")
    data_test_split+=("")
fi
if [ "$test_synthia" = true ] ; then
    dataset_names+=("synthia")
    dataset_types+=("SynthiaDataset")
    dataset_data_root+=("data/synthia/")
    dataset_img_dir+=("RGB")
    dataset_ann_dir+=("GT/LABELS/LABELS")
    data_test_split+=("")
fi
if [ "$test_gta_val" = true ] ; then
    dataset_names+=("gta_val")
    dataset_types+=("GTADataset")
    dataset_data_root+=("data/")
    dataset_img_dir+=("gta/images")
    dataset_ann_dir+=("gta/labels")
    data_test_split+=("data.test.split=\"gta_splits/val_split.txt\"")
fi
if [ "$test_synthia_val" = true ] ; then
    dataset_names+=("synthia_val")
    dataset_types+=("SynthiaDataset")
    dataset_data_root+=("data/")
    dataset_img_dir+=("synthia/RGB")
    dataset_ann_dir+=("synthia/GT/LABELS/LABELS")
    data_test_split+=("data.test.split=\"synthia_splits/val_split.txt\"")
fi
echo -e "Test Datasets:"
for dataset_idx in "${!dataset_names[@]}"; do
    echo -e "   ${dataset_names[dataset_idx]}"
done
script_dir=$(pwd)
cd ~/work/transformer-domain-generalization || return
find ./tmp_files -name '*.*' -mmin +3000 -delete
for work_dirs_idx in "${!work_dirs[@]}"; do
  letter=$(echo "$((suffix + work_dirs_idx))" | xxd -p -r)
  if [[ -f "${work_dirs[work_dirs_idx]}/latest.pth" ]] && [[ ! -f "${work_dirs[work_dirs_idx]}/iter_${max_iters}.pth" ]] && [[ "$override" = false ]]; then
      # Resume Training
      port=$(comm -23 <(seq 20000 65535 | sort) <(ss -tan | awk '{print $4}' | cut -d':' -f2 | sort -u) | shuf | head -n 1)
      srun --output "${script_dir}/train_${letter}.log"\
       python ./tools/train.py\
       "${main_config}"\
        --seed ${seeds[work_dirs_idx]}\
        --launcher="slurm"\
        --resume-from "${work_dirs[work_dirs_idx]}/latest.pth"\
        --options work_dir="${work_dirs[work_dirs_idx]}"\
        runner.work_dir="${work_dirs[work_dirs_idx]}"\
        data.train.type="$data_train_type"\
        data.train.data_root="$data_train_data_root"\
        $(echo -n "$data_train_split")\
        data.train.img_dir="$data_train_img_dir"\
        data.train.ann_dir="$data_train_ann_dir"\
        data.test.type="${dataset_types[0]}"\
        dataset_type="${dataset_types[0]}"\
        data_root="${dataset_data_root[0]}"\
        data.test.data_root="${dataset_data_root[0]}"\
        data.test.img_dir="${dataset_img_dir[0]}"\
        data.test.ann_dir="${dataset_ann_dir[0]}"\
        dist_params.backend='nccl' dist_params.port=${port}
  elif [[ ! -f "${work_dirs[work_dirs_idx]}/iter_${max_iters}.pth" ]] || [[ "$override" = true ]]; then
      # Start training
      port=$(comm -23 <(seq 20000 65535 | sort) <(ss -tan | awk '{print $4}' | cut -d':' -f2 | sort -u) | shuf | head -n 1)
      srun --output "${script_dir}/train_${letter}.log"\
       python ./tools/train.py\
       "${main_config}"\
        --seed ${seeds[work_dirs_idx]}\
        --launcher="slurm"\
        --options work_dir="${work_dirs[work_dirs_idx]}"\
        runner.work_dir="${work_dirs[work_dirs_idx]}"\
        data.train.type="$data_train_type"\
        data.train.data_root="$data_train_data_root"\
        $(echo -n "$data_train_split")\
        data.train.img_dir="$data_train_img_dir"\
        data.train.ann_dir="$data_train_ann_dir"\
        data.test.type="${dataset_types[0]}"\
        dataset_type="${dataset_types[0]}"\
        data_root="${dataset_data_root[0]}"\
        data.test.data_root="${dataset_data_root[0]}"\
        data.test.img_dir="${dataset_img_dir[0]}"\
        data.test.ann_dir="${dataset_ann_dir[0]}"\
        dist_params.backend='nccl' dist_params.port=${port}
  fi
done
if [ "$test_models" = true ] ; then
    for dataset_idx in "${!dataset_names[@]}"; do
      echo -e "Test all on ${dataset_names[dataset_idx]}"
      for checkpoint_idx in "${!work_dirs[@]}"; do
        letter=$(echo "$((suffix + checkpoint_idx))" | xxd -p -r)
        log_file="${script_dir}/test_${letter}_on_${dataset_names[dataset_idx]}.log"
        isInFile=$( (cat "${log_file}" || true) | grep -c "mIoU")
        if [ $isInFile -eq 0 ]; then
            echo -e "Test all on ${dataset_names[dataset_idx]}" >> "${log_file}"
            echo -e "Test for ${checkpoint_idx}:"
            echo -e "Test for ${checkpoint_idx}:" >> "${log_file}"
            srun --output "${log_file}"\
             python ./tools/test.py\
             "${main_config}"\
             "${work_dirs[checkpoint_idx]}/latest.pth"\
             --gpu-collect\
             --eval-options efficient_test='True'\
             --no-progress-bar\
             --options \
                data.test.type="${dataset_types[dataset_idx]}"\
                dataset_type="${dataset_types[dataset_idx]}"\
                data_root="${dataset_data_root[dataset_idx]}"\
                data.test.data_root="${dataset_data_root[dataset_idx]}"\
                data.test.img_dir="${dataset_img_dir[dataset_idx]}"\
                data.test.ann_dir="${dataset_ann_dir[dataset_idx]}"\
                $(echo -n "${data_test_split[dataset_idx]}")
            echo -e "___________________________________________________"
        fi
      done
    done
fi
