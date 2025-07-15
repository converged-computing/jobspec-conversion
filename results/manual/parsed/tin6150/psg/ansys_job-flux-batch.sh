#!/bin/bash
#FLUX: --job-name=AnsysSingularityTest
#FLUX: --queue=lr5
#FLUX: -t=109800
#FLUX: --urgency=16

AnsysCmd='singularity exec  -B /global/home/groups-sw,/global/software/sl-6.x86_64,/global/scratch /global/scratch/tin/singularity-repo/sl6_lbl.envMod+ipmi.simg /global/scratch/tin/singularity-repo/ansys.helper.sh'
$AnsysCmd  input.testfile
