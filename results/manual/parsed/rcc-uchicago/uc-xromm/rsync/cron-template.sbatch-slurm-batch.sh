#!/bin/bash
#SBATCH --account=cron-account
#SBATCH --output=cron.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=05:00:00
#SBATCH --partition=cron
#SBATCH --qos=cron

SCHEDULE='59 23 * * *'
SSH_PREFIX="ssh -i /home/$(whoami)/.ssh"       # prefix to ssh keys
ROSS_EXP=/project/rossc/Orofacial/BiteForce/Data     # top-level destination directory
RIPPLE_DATA="labadmin@128.135.180.217:/cygdrive/c/Users/labadmin/Trellis/dataFiles"
rsync -av -e "$SSH_PREFIX/id_behavrsync"  $RIPPLE_DATA  $ROSS_EXP/<...>
rsync -avz -e "$SSH_PREFIX/id_behavrsync"  $RIPPLE_DATA  $ROSS_EXP/<...>
RT_MATLAB_MODELS="labadmin@128.135.180.236:/cygdrive/c/Models"
rsync -av -e "$SSH_PREFIX/id_behavrsync"  $RT_MATLAB_MODELS  $ROSS_EXP/<...>
rsync -avz -e "$SSH_PREFIX/id_behavrsync" $RT_MATLAB_MODELS  $ROSS_EXP/<...>
PROCAPTURE="labadmin@128.135.180.159"
C_DATA=/cygdrive/c/Data 
D_DATA=/cygdrive/d/Data 
E_DATA=/cygdrive/e/Data 
F_DATA=/cygdrive/f/Data 
rsync -av -e "$SSH_PREFIX/id_behavrsync" $PROCAPTURE:$C_DATA :$D_DATA :$E_DATA :$F_DATA  $ROSS_EXP/<...>
rsync -avz -e "$SSH_PREFIX/id_behavrsync" $PROCAPTURE:$C_DATA :$D_DATA :$E_DATA :$F_DATA  $ROSS_EXP/<...> 
sbatch --quiet --begin=$(next-cron-time "$SCHEDULE") cron_template.sbatch
