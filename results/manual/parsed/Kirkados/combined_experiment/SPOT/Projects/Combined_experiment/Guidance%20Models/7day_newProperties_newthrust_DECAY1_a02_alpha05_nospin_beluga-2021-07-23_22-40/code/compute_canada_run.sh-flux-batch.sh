#!/bin/bash
#FLUX: --job-name=crunchy-hippo-7000
#FLUX: -c=40
#FLUX: -t=345600
#FLUX: --urgency=16

niagara=false
if $niagara
then
   module load CCEnv arch/avx512
   module load StdEnv/2018.3
   module load python/3.7.4
   module load scipy-stack
   #module load gcc/8.3.0
   module load geos
   source $HOME/env/bin/activate   
   # Do below before running
   #virtualenv --system-site-packages $HOME/env 
   #source $HOME/env/bin/activate     
   #pip3 install --upgrade pip
   #pip3 install -r requirements.txt
   #pip3 install PyVirtualDisplay
else
   module load StdEnv/2018.3
   module load python/3.7.4
   module load scipy-stack
   module load geos
   virtualenv --no-download $SLURM_TMPDIR/env 
   source $SLURM_TMPDIR/env/bin/activate   
   pip3 install --no-index --upgrade pip
   pip3 install --no-index -r requirements.txt
   pip3 install EasyProcess-0.3-py2.py3-none-any.whl
   pip3 install PyVirtualDisplay-2.0-py2.py3-none-any.whl
fi
   #module load StdEnv/2020 # if you haven't upgraded to 2020 as the default yet
tensorboard --logdir=$SCRATCH/D4PG-Phase-3/Tensorboard/Current/ --host=0.0.0.0 &
python3 -u main.py
