#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=48
#SBATCH --time=4:00:00
#SBATCH --partition=general
#SBATCH --account=a_omara


# This script runs MD for 4 hours, then checks whether the job is complete by 
# comparing the number of steps in the log file with nsteps in the mdp.  
# If the job is not done, it resubmits automatically.
#
# Do not specify a job name, instead rename this file with the intended job name / system name
#
# Requires the following files
#
#   This script, saved with the filename = <SYSTEMNAME>              NB: note no extenstion
#   MDP file with filename =               <SYSTEMNAME>.mdp          This is a control file, it contains instructions for gromacs
#
# and then either:
#
#   Input coordinates with filename :       <SYSTEMNAME>_start.gro
#   Index file with filename :              <SYSTEMNAME>.ndx (make with gmx make_ndx)
#   Topology file with filename :           <SYSTEMNAME>.top
#   All force field include files as specified in the topology file
#
# or:
#
#   A .tpr file with filename :             <SYSTEMNAME>.tpr (this is the entire simulation in a single binary,m made with gmx grompp)
#
#
# change the account to your own accounting group on bunya

#####  SETUP ENVIRONMENT  #####

module load  gromacs/2021.3-foss-2021a
module list

# Define error function so we can see the error code given when something
# important crashes
errexit ()

{
    errstat=$?
    if [ $errstat != 0 ]; then
        # A brief nap so slurm kills us in normal termination
        # Prefer to be killed by slurm if slurm detected some resource excess
        sleep 5
        echo "Job returned error status $errstat - stopping job sequence $SLURM_JOB_NAME at job $SLURM_JOB_ID"
        exit $errstat
    fi
}



GMX='gmx'
GMXMDRUN='gmx mdrun -maxh 3.95'

#####  START MD WITH A GROMPP  #####

## GROMPP if there's no TPR file (eg, this is the first submission)
if [ ! -f ${SLURM_JOB_NAME}.tpr ]; then
    $GMX grompp -f ${SLURM_JOB_NAME}.mdp -c ${SLURM_JOB_NAME}_start.gro -o ${SLURM_JOB_NAME}.tpr -p ${SLURM_JOB_NAME}.top  -n ${SLURM_JOB_NAME}.ndx -maxwarn 2 &> ${SLURM_JOB_NAME}_grompp_${SLURM_JOB_ID}.txt
fi

#####  RUN MD FOR 4 HOURS  #####

$GMXMDRUN -v -deffnm ${SLURM_JOB_NAME} -cpi ${SLURM_JOB_NAME}.cpt || errexit

#####  CHECK IF JOB IS DONE; IF NOT DONE RESUBMIT THIS SCRIPT  #####


# Check the log file for the number of steps completed
steps_done=`perl -n -e'/Statistics over (\d+) steps using (\d+) frames/ && print $1' ${SLURM_JOB_NAME}.log`
# Check the mdp file for the number of steps we want
steps_wanted=`perl -n -e'/nsteps\s*=\s*(\d+)/ && print $1' ${SLURM_JOB_NAME}.mdp`
# Resubmit if we need to
if (( steps_done < steps_wanted )); then
    echo "Job ${SLURM_JOB_NAME} terminated with ${SLURM_JOB_NAME}/${SLURM_JOB_NAME} steps finished." 
    echo "Submitting next job in sequence ${SLURM_JOB_NAME}."
    sbatch ${SLURM_JOB_NAME}
fi

#####  END  #####
