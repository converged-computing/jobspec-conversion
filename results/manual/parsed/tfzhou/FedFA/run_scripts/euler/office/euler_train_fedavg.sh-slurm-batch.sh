#!/bin/bash
#SBATCH --output=logs_pyfed/config.office.fedavg.trial0.out
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpumem:22g
#SBATCH --mem-per-cpu=10000
#SBATCH --time=2-00:00:00

source ../../../../pytorch-1.11/bin/activate
module load gcc/8.2.0 python_gpu/3.10.4
rsync -aP /cluster/work/cvl/tiazhou/data/medical/FL/office_caltech_10_dataset.zip ${TMPDIR}/
unzip -q ${TMPDIR}/office_caltech_10_dataset.zip -d ${TMPDIR}/
cd ../../../
trial=1
python main.py --config 'config.office.fedavg' \
               --server 'euler' \
               --trial $trial \
               --run_name 'fedavg_trial_'$trial \
               --run_notes 'trial '$trial': fedavg' \
               --exp_name 'fedavg'
