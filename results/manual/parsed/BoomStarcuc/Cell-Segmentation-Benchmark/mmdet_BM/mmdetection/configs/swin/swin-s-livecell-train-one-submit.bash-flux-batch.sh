#!/bin/bash
#FLUX: --job-name=swampy-peanut-7833
#FLUX: --urgency=16

tissues=('A172' 'BT474' 'BV2' 'Huh7' 'MCF7' 'SHSY5Y' 'SkBr3' 'SKOV3')
CONFIG_DIR='mmdetection/configs/swin'
for tissue in ${tissues[@]}
do
    # Copy A.py to a new file, replacing 'Epidermis' with the tissue name
    cp $CONFIG_DIR/mask_rcnn_swin-s-p4-w7_fpn_fp16_ms-crop-50e_coco_livecell_A172.py $CONFIG_DIR/mask_rcnn_swin-s-p4-w7_fpn_fp16_ms-crop-50e_coco_livecell_${tissue}.py 
    sed -i "s/A172/${tissue}/g" $CONFIG_DIR/mask_rcnn_swin-s-p4-w7_fpn_fp16_ms-crop-50e_coco_livecell_${tissue}.py
done
dir=$CONFIG_DIR/livecell_swin-s_one_for_all_slurm
out_dir='/shared/rc/spl/mmdet_output/One_to_all/livecell/swin-s'
if [[ ! -e $dir ]]; then
    mkdir $dir
elif [[ ! -d $dir ]]; then
    echo "$dir already exists but is not a directory" 1>&2
fi
for tissue in ${tissues[@]}
do
    echo "CONFIG_DIR: $CONFIG_DIR"
    echo "OUTPUT_DIR: '$out_dir/mask_rcnn_swin-s-p4-w7_fpn_fp16_ms-crop-50e_coco_livecell_${tissue}"
    # echo ${i##*/}
    echo '#!/bin/bash' > ${dir}/swin-s-livecell-${tissue}.slurm
    echo '#SBATCH -J swin-s-livecell-on-'${tissue} >> ${dir}/swin-s-livecell-${tissue}.slurm
    echo '#SBATCH -A sada-cnmi' >> ${dir}/swin-s-livecell-${tissue}.slurm
    echo '#SBATCH -p tier3' >> ${dir}/swin-s-livecell-${tissue}.slurm
    echo '#SBATCH --time=10:0:0' >> ${dir}/swin-s-livecell-${tissue}.slurm
    echo '#SBATCH --output=%x_%j.out' >> ${dir}/swin-s-livecell-${tissue}.slurm
    echo '#SBATCH --error=%x_%j.err' >> ${dir}/swin-s-livecell-${tissue}.slurm
    echo '#SBATCH --mem=200G' >> ${dir}/swin-s-livecell-${tissue}.slurm
    echo '#SBATCH --gres=gpu:a100:2' >> ${dir}/swin-s-livecell-${tissue}.slurm
    echo 'spack load cuda@11.0.2%gcc@9.3.0/lrd2rcw'  >> ${dir}/swin-s-livecell-${tissue}.slurm
    echo 'cd mmdetection'  >> ${dir}/swin-s-livecell-${tissue}.slurm
    echo 'nvidia-smi'  >> ${dir}/swin-s-livecell-${tissue}.slurm
    echo 'sh mmdetection/tools/dist_train.sh '$CONFIG_DIR'/mask_rcnn_swin-s-p4-w7_fpn_fp16_ms-crop-50e_coco_livecell_'${tissue}'.py 2 --work-dir '$out_dir'/mask_rcnn_swin-s-p4-w7_fpn_fp16_ms-crop-50e_coco_livecell_'${tissue} >> ${dir}/swin-s-livecell-${tissue}.slurm
    sbatch ${dir}/swin-s-livecell-${tissue}.slurm
done
