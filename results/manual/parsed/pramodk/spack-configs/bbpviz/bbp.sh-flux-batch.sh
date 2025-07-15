#!/bin/bash
#FLUX: --job-name="neuron-coreneuron-stack"
#FLUX: --exclusive
#FLUX: --queue=interactive
#FLUX: -t=28800
#FLUX: --priority=16

export TAU_OPTIONS='-optPDTInst -optNoCompInst -optRevert -optVerbose -optTauSelectFile=~/spackconfig/nrnperfmodels.tau'

uninstall_package() {
    spack uninstall -y -f -d -a neuron
    spack uninstall -y -f -d -a coreneuron
    spack uninstall -y -f -d -a mod2c
    spack uninstall -y -f -d -a nrnh5
    spack uninstall -y -f -d -a reportinglib
    spack uninstall -y -f -d -a neurodamus
    spack uninstall -y -f -d -a neuron-nmodl
    spack uninstall -y -f -d -a neuronperfmodels
}
extra_opt="--log-format=junit --dirty"
export TAU_OPTIONS='-optPDTInst -optNoCompInst -optRevert -optVerbose -optTauSelectFile=~/spackconfig/nrnperfmodels.tau'
compilers=(
    "pgi"
    "gcc"
    "intel"
)
declare -A mpi
mpi["pgi"]="mpich"
mpi["gcc"]="mvapich2"
mpi["intel"]="intelmpi"
module purge all
spack reindex
uninstall_package
spack purge -s
set -e
for compiler in "${compilers[@]}"
do
    # we dont have hdf5 compiled with PGI
    if [[ $compiler == *"pgi"* ]]; then
        spack install $extra_opt coreneuron@perfmodels +mpi +report +gpu %$compiler ^${mpi[$compiler]}
        # for profiling purpose
        spack install $extra_opt coreneuron@perfmodels +profile +mpi +report +gpu %$compiler ^${mpi[$compiler]}
    fi
    spack install $extra_opt mod2c@develop %$compiler
    spack install $extra_opt mod2c@github  %$compiler
    spack install $extra_opt nrnh5@develop %$compiler ^${mpi[$compiler]}
    spack install $extra_opt neuron@hdf +mpi %$compiler ^${mpi[$compiler]}
    spack install $extra_opt neuron@develop +mpi %$compiler ^${mpi[$compiler]}
    spack install $extra_opt reportinglib %$compiler ^${mpi[$compiler]}
    spack install $extra_opt neurodamus@master +compile %$compiler ^${mpi[$compiler]}
    spack install $extra_opt neurodamus@develop +compile %$compiler ^${mpi[$compiler]}
    spack install $extra_opt neurodamus@hdf +compile %$compiler ^${mpi[$compiler]}
    spack install $extra_opt coreneuron@hdf +mpi +report %$compiler ^${mpi[$compiler]}
    spack install $extra_opt coreneuron@develop +mpi +report %$compiler ^${mpi[$compiler]}
    spack install $extra_opt coreneuron@github +mpi +report %$compiler ^${mpi[$compiler]}
    spack install $extra_opt neuronperfmodels@neuron %$compiler ^${mpi[$compiler]}
    spack install $extra_opt coreneuron@perfmodels +mpi +report %$compiler ^${mpi[$compiler]}
    # for profiling purpose
    spack install $extra_opt neuronperfmodels@neuron +profile %$compiler ^${mpi[$compiler]}
    spack install $extra_opt coreneuron@perfmodels +profile +mpi +report %$compiler ^${mpi[$compiler]}
done
