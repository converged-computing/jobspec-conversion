#!/bin/bash
#FLUX: --job-name=rf-0-smogn
#FLUX: --exclusive
#FLUX: --queue=amd
#FLUX: -t=356400
#FLUX: --priority=16

hostname
module load /sw/spack-amd/spack/modules/linux-centos8-zen2/singularity/3.7.0-gcc-10.2.0
cat > run.sh << 'EOF'
echo 'HELLO BOX'
codedir=/work/frauke/ai4eo-hyperview/hyperview/random_forest
datadir=/work/shared_data/2022-ai4eo_hyperview
conda init
source ~/.bashrc
conda activate ai4eo_hyper
echo "conda env activated"
echo $codedir
cd $codedir
PYTHONPATH=$PYTHONPATH:"$codedir"
export PYTHONPATH
python3 rf_train.py --in-data $datadir --submission-dir $codedir/submissions --n-trials 100 --n-estimators 800 1200 --max-depth 200 500 --max-depth-none --min-samples-leaf 1 5 --regressors RandomForest --folds 5 --save-eval --eval-dir $codedir/evaluation --save-model --model-dir $codedir/models --smogn --col-ix 0
EOF
singularity exec --bind /mnt/lustre02/work/ka1176/:/work /mnt/lustre02/work/ka1176/frauke/ai4eo-hyperview/hyperview/random_forest/images/ai4eo-hyperview_rf.sif /bin/bash /work/frauke/ai4eo-hyperview/hyperview/random_forest/jobs/run.sh
