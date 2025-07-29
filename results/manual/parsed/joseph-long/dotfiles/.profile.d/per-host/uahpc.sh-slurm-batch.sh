#!/bin/bash
#FLUX: --job-name=docker_to_singularity
#FLUX: --queue=standard
#FLUX: -t=14400
#FLUX: --urgency=16

export MANPATH='$MANPATH:/home/u32/josephlong/devel/texlive/2021/texmf-dist/doc/man'
export INFOPATH='$INFOPATH:/home/u32/josephlong/devel/texlive/2021/texmf-dist/doc/info'
export PATH='/groups/jrmales/josephlong/.local/bin:$PATH'
export LD_LIBRARY_PATH='/groups/jrmales/josephlong/.local/lib:$LD_LIBRARY_PATH'
export PKG_CONFIG_PATH='/groups/jrmales/josephlong/.local/lib/pkgconfig:$PKG_CONFIG_PATH'

export MANPATH="$MANPATH:/home/u32/josephlong/devel/texlive/2021/texmf-dist/doc/man"
export INFOPATH="$INFOPATH:/home/u32/josephlong/devel/texlive/2021/texmf-dist/doc/info"
export PATH="$PATH:/home/u32/josephlong/devel/texlive/2021/bin/x86_64-linux"
export PATH="/groups/jrmales/josephlong/.local/bin:$PATH"
export LD_LIBRARY_PATH="/groups/jrmales/josephlong/.local/lib:$LD_LIBRARY_PATH"
export PKG_CONFIG_PATH="/groups/jrmales/josephlong/.local/lib/pkgconfig:$PKG_CONFIG_PATH"
if command -v srun &> /dev/null; then
    export _UAHPC_SYS=SLURM
elif command -v qstat &> /dev/null; then
    export _UAHPC_SYS=PBS
fi
if [[ $(command -v module) == "module" && $_UAHPC_SYS == "SLURM" ]]; then
	echo SLURM
elif [[ $(command -v module) == "module" ]]; then
    module load singularity
    module load intel/mkl/64
fi
function d2s() {
    if [[ -z $1 ]]; then
        echo "missing image name"
        return 1
    fi
    pushd ~/devel/simgs/
    sbatch <<EOF
hostname
singularity pull --disable-cache --force docker://${1}
EOF
    popd
}
alias myq="squeue -u $USER"
alias kill_all_my_jobs="squeue -u $USER | tail -n +2 | awk '{print \$1}' | xargs qdel"
