#!/bin/bash
#FLUX: --job-name=rashV8
#FLUX: --queue=Mlong
#FLUX: -t=1209600
#FLUX: --urgency=16

module load openfoam-org/6-10.3.0
source /opt/modules/spack_installs/linux-centos7-broadwell/gcc-10.3.0/openfoam-org-6-vqdvitbtcrbdg66aa2x2zpf4jtpcvqks/etc/bashrc
python genGeomFPMAll.py
rm -rf processor*
decomposePar >> log.decomposePar
