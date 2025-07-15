#!/bin/bash
#FLUX: --job-name=orion_lateral
#FLUX: -c=2
#FLUX: -t=36000
#FLUX: --priority=16

export ORION_DB_ADDRESS='/home/hrb/dev/lateral-view-analysis/orion.pkl'
export ORION_DB_TYPE='pickleddb'
export ORION_DB_NAME='lateral_view_analysis'
export DATADIR='$SLURM_TMPDIR/images-224'

module load python/3.7.4
virtualenv --no-download $SLURM_TMPDIR/env
source $SLURM_TMPDIR/env/bin/activate
pip install --no-index --upgrade pip
cp /home/hrb/dev/lateral-view-analysis/requirements.txt $SLURM_TMPDIR/requirements.txt
sed -i '1 i\-f /home/hrb/.wheels' $SLURM_TMPDIR/requirements.txt
pip install --no-index -r $SLURM_TMPDIR/requirements.txt
export ORION_DB_ADDRESS='/home/hrb/dev/lateral-view-analysis/orion.pkl'
export ORION_DB_TYPE='pickleddb'
export ORION_DB_NAME='lateral_view_analysis'
export DATADIR=$SLURM_TMPDIR/images-224
time rsync -a --info=progress2 /lustre04/scratch/cohenjos/PC/images-224.tar $SLURM_TMPDIR/
time tar xf $SLURM_TMPDIR/images-224.tar -C $SLURM_TMPDIR/
cd ~/dev/lateral-view-analysis/
DATADIRVAR='CLUSTER'
CSV=~/projects/rpp-bengioy/jpcohen/PADCHEST_SJ/labels_csv/joint_PA_L.csv
SPLIT=~/projects/rpp-bengioy/jpcohen/PADCHEST_SJ/labels_csv/splits_PA_L_666.pkl
OUTPUT=/lustre04/scratch/cohenjos/PC-output/hadrien
EPOCHS=40
SEED=666
orion -v hunt -n lateral-view-multitask3 --config orion_config.yaml ./hyperparam_search.py --data_dir $DATADIRVAR --csv_path $CSV --splits_path $SPLIT --output_dir $OUTPUT --exp_name {trial.id} --seed $SEED --epochs $EPOCHS --model-type 'multitask' --target 'joint' --batch_size 8 --learning_rate 'orion~loguniform(1e-5, 1e-3, shape=3)' --dropout 'orion~uniform(0, 5, discrete=True)' --optim 'adam' --mt-task-prob 0.0 --mt-join "orion~choices(['concat', 'max', 'mean'])" --log '{exp.working_dir}/{exp.name}_{trial.id}/exp.log'
