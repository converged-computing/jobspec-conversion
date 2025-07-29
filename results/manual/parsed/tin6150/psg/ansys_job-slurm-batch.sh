#!/bin/bash
#SBATCH --job-name=AnsysSingularityTest
#SBATCH --account=scs
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-06:30:00
#SBATCH --partition=lr5
#SBATCH --qos=lr_normal

AnsysCmd='singularity exec  -B /global/home/groups-sw,/global/software/sl-6.x86_64,/global/scratch /global/scratch/tin/singularity-repo/sl6_lbl.envMod+ipmi.simg /global/scratch/tin/singularity-repo/ansys.helper.sh'
$AnsysCmd  input.testfile
