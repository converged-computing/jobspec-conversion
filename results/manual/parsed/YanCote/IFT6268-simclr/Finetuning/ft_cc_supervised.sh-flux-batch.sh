#!/bin/bash
#FLUX: --job-name=butterscotch-nalgas-5141
#FLUX: -t=840
#FLUX: --urgency=16

format_time() {
  ((h=${1}/3600))
  ((m=(${1}%3600)/60))
  ((s=${1}%60))
  printf "%02d:%02d:%02d\n" $h $m $s
 }
echo 'Copying and unpacking dataset on local compute node...'
tar -xf ~/scratch/data/images-224.tar -C $SLURM_TMPDIR
echo 'Copying Data_Entry_2017.csv ...'
cp -v ~/scratch/data/Data_Entry_2017.csv $SLURM_TMPDIR
echo 'List1'
ls -l -d ~/scratch/*/
echo 'List2'
ls -l -d ~/*/
dt=$(date '+%d-%m-%Y-%H-%M-%S-%3N');
echo "Time Signature: ${dt}"
mlflow_dir="/home/${1:-gauthies}/IFT6268-simclr/Finetuning/mlruns"
out_dir_f="/home/${1:-gauthies}/finetuning/"
mkdir -p $out_dir_f
out_dir="${out_dir_f}${dt}-$SLURM_JOB_ID"
mkdir -p $out_dir
echo "Using OutDir: : ${out_dir}"
echo 'Starting task !'
echo 'Load Modules Python !'
module load python/3.7
module load scipy-stack
echo 'Creating VENV'
virtualenv --no-download $SLURM_TMPDIR/env
echo 'Source VENV'
source $SLURM_TMPDIR/env/bin/activate
echo 'Installing package'
pip3 install --no-index pyasn1
echo -e 'Installing tensorflow_gpu-hub ******************************\n'
pip3 install --no-index tensorflow_gpu
echo -e 'Installing TensorFlow-hub ******************************\n'
pip3 install --no-index ~/python_packages/tensorflow-hub/tensorflow_hub-0.9.0-py2.py3-none-any.whl
pip3 install --no-index tensorboard
pip3 install --no-index termcolor
pip3 install --no-index pandas
pip3 install --no-index protobuf
pip3 install --no-index termcolor
pip3 install --no-index Markdown
pip3 install --no-index h5py
pip3 install --no-index pyYAML
pip3 install --no-index mlflow
pip3 install --no-index scikit-learn
pip3 install --no-index psutil
echo -e 'Installing TensorFlow-Datasets ******************************\n'
pip3 install --no-index ~/python_packages/tensorflow-datasets/googleapis_common_protos-1.52.0-py2.py3-none-any.whl
pip3 install --no-index ~/python_packages/tensorflow-metadata/absl_py-0.10.0-py3-none-any.whl
pip3 install --no-index ~/python_packages/tensorflow-datasets/promise-2.3
echo -e 'Installing tensorflow_metadata ******************************\n'
pip3 install --no-index ~/python_packages/tensorflow-metadata/tensorflow_metadata-0.24.0-py3-none-any.whl
pip3 install --no-index ~/python_packages/tensorflow-metadata/tensorflow_metadata-0.25.0-py3-none-any.whl
echo -e 'Installing tensorflow_datasets ******************************\n'
pip3 install --no-index ~/python_packages/tensorflow-datasets/zipp-3.4.0-py3-none-any.whl
echo 'Calling python script'
stdbuf -oL python -u ./Finetuning/finetuning_supervised.py \
--config ./Finetuning/config_supervised_8.yml \
--xray_path $SLURM_TMPDIR \
--output_dir $out_dir \
--mlflow_dir $mlflow_dir | tee finetuning_${dt}.txt
echo "Time Signature: ${dt}"
echo "Saving Monolytic File Archive in : ${out_dir}/finetuning${dt}.txt"
echo "Script completed in $(format_time $SECONDS)"
mv finetuning_${dt}.txt "${out_dir}/finetuning_${dt}.txt"
