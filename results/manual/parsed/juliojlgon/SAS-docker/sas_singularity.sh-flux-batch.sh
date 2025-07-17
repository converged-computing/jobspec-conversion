#!/bin/bash
#FLUX: --job-name=strawberry-rabbit-7349
#FLUX: --queue=shared-cpu
#FLUX: -t=300
#FLUX: --urgency=16

export HOME='/home/heasoft'

echo "SAS_SING_PORT == ${SAS_DOCKER_PORT:=8880}\""
cmd=$@
echo "sas_singularity with command: \"$@\""
cd $(realpath $PWD)
IMAGE=/srv/beegfs/scratch/shares/astro/xmm/singularity/sas_19.1.0-squashed-2021-04-22.sif
module load GCCcore/8.2.0 Singularity/3.4.0-Go-1.12
echo "."
echo "."
echo "using WORKDIR: ${WORKDIR:=$PWD}"
[ -s /tmp/.X11-unix ] || { echo "no /tmp/.X11-unix? no X? not allowed!"; }
mkdir -pv $WORKDIR/pfiles
set -x
singularity exec \
        -B $WORKDIR:/home/heasoft \
        $IMAGE \
        bash -c "
export HOME=/home/heasoft
cd \$HOME
. /usr/local/bin/init.sh
. /usr/local/bin/init_sas.sh
echo -e '\\e[31mrunning\\e[37m $cmd\\e[0m'
$cmd
"
set +x
