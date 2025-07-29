#!/bin/bash
#SBATCH --output=heavyAI.out
#SBATCH --error=heavyAI.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=4G
#SBATCH --time=00:00:20
#SBATCH --partition=gpu

export container_image='/n/singularity_images/OOD/omnisci/heavyai-ee-cuda_v7.2.2.sif'
export SING_BINDS='$SING_BINDS -B ${HEAVYAIBASE}/var/lib/heavyai:/var/lib/heavyai '

source setup_heavyAI.sh
cd "${HEAVYAIBASE}"
export container_image="/n/singularity_images/OOD/omnisci/heavyai-ee-cuda_v7.2.2.sif"
export SING_BINDS=" -B /etc/nsswitch.conf -B /etc/sssd/ -B /var/lib/sss -B /etc/slurm -B /slurm -B /var/run/munge  -B `which sbatch ` -B `which srun ` -B `which sacct ` -B `which scontrol `   -B /usr/lib64/slurm/ "
export SING_BINDS="$SING_BINDS -B ${HEAVYAIBASE}/var/lib/heavyai:/var/lib/heavyai "
echo ""
echo "===================================================================== "
echo "execute ssh command from local computer:"
echo "ssh -NL ${port}:${SLURMD_NODENAME}:${port} ${USER}@login.rc.fas.harvard.edu"
echo "===================================================================== "
echo ""
SINGULARITYENV_MAPD_WEB_PORT=${MAPD_WEB_PORT} SINGULARITYENV_MAPD_TCP_PORT=${MAPD_TCP_PORT} SINGULARITYENV_MAPD_HTTP_PORT=${MAPD_HTTP_PORT} SINGULARITYENV_MAPD_CALCITE_PORT=${MAPD_CALCITE_PORT} singularity run --nv $SING_BINDS --pwd /opt/heavyai $container_image
