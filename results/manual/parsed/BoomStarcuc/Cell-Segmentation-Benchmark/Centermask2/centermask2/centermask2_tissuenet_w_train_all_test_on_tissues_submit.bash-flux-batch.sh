#!/bin/bash
#FLUX: --job-name=crunchy-fudge-9107
#FLUX: --urgency=16

declare -a arr=("Colon" "lymph_node_metastasis" "Spleen" "Pancreas" "Epidermis" "Breast" "Lymph_Node" "Tonsil" "Lung" "Esophagus")
RESNEST_ROOT_DIR='centermask2'
CONFIG_DIR='centermask2/benchmark_config'
dir=$RESNEST_ROOT_DIR/tissuenet_w_all_to_all_test_slurm
out_dir='/shared/rc/spl/mmdet_output/All_to_all/wholecell_oc/centermask2_wholecell_train_all'
if [[ ! -e $dir ]]; then
    mkdir $dir
elif [[ ! -d $dir ]]; then
    echo "$dir already exists but is not a directory" 1>&2
fi
for i in "${arr[@]}"
do
    echo "EXPERIMENT:$i"
    echo "ROOT_DIR: $RESNEST_ROOT_DIR"
    echo "CONFIG_DIR: $CONFIG_DIR"
    echo "OUTPUT_DIR: '$out_dir'/predictions/centermask2_tissuenet_w_train_all_test_on_'$i"
    echo ${i##*/}
    echo '#!/bin/bash' > ${dir}/centermask2_tissuenet_w_train_All_test_on_${i}.slurm
    echo '#SBATCH -J centermask2_tissuenet_w_train_all_test_on_'${i} >> ${dir}/centermask2_tissuenet_w_train_All_test_on_${i}.slurm
    echo '#SBATCH -A sada-cnmi' >> ${dir}/centermask2_tissuenet_w_train_All_test_on_${i}.slurm
    echo '#SBATCH -p tier3' >> ${dir}/centermask2_tissuenet_w_train_All_test_on_${i}.slurm
    echo '#SBATCH --time=24:0:0' >> ${dir}/centermask2_tissuenet_w_train_All_test_on_${i}.slurm
    echo '#SBATCH --output=%x_%j.out' >> ${dir}/centermask2_tissuenet_w_train_All_test_on_${i}.slurm
    echo '#SBATCH --error=%x_%j.err' >> ${dir}/centermask2_tissuenet_w_train_All_test_on_${i}.slurm
    echo '#SBATCH --mem=200G' >> ${dir}/centermask2_tissuenet_w_train_All_test_on_${i}.slurm
    echo '#SBATCH --gres=gpu:a100:1' >> ${dir}/centermask2_tissuenet_w_train_All_test_on_${i}.slurm
    echo 'spack load cuda@11.0.2%gcc@9.3.0/lrd2rcw'  >> ${dir}/centermask2_tissuenet_w_train_All_test_on_${i}.slurm
    echo 'cd centermask2'  >> ${dir}/centermask2_tissuenet_w_train_All_test_on_${i}.slurm
    echo 'nvidia-smi'  >> ${dir}/centermask2_tissuenet_w_train_All_test_on_${i}.slurm
    echo 'python '$RESNEST_ROOT_DIR'/train_net.py --config-file '$CONFIG_DIR'/tissuenet_wholecell_train_all_test_on_'$i'.yaml --num-gpus 1 --eval-only MODEL.WEIGHTS '$out_dir'/model_0099999.pth OUTPUT_DIR '$out_dir'/predictions/centermask2_tissuenet_w_train_all_test_on_'$i >> ${dir}/centermask2_tissuenet_w_train_All_test_on_${i}.slurm
    sbatch ${dir}/centermask2_tissuenet_w_train_All_test_on_${i}.slurm
done
