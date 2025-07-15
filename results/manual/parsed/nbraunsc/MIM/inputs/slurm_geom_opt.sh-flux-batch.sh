#!/bin/bash
#FLUX: --job-name=muffled-gato-8094
#FLUX: --urgency=16

if [ -z ${HOME+x} ];
then
    export HOME=$(echo ~)
    source /etc/profile
    source /etc/bashrc
    source $HOME/.bashrc
fi
hostname
module reset
module load site/tinkercliffs-rome/easybuild/setup  #only for infer
module load site/tinkercliffs/easybuild/setup  #only for infer
module load Anaconda3/2020.07
module load gcc/8.2.0
source activate mim_env
cd $SLURM_SUBMIT_DIR
finished=0
while [ "$finished" != "1" ]
do
    finished=$(python checker.py $FOLDER)
    sleep 10
done
echo "Calculations are done!, end status:"
echo $finished
python eg_reap.py $FOLDER >> eg_reap.out
echo "Reap is done!"
exit;
