#!/bin/bash
#FLUX: --job-name=land_use
#FLUX: --exclusive
#FLUX: --queue=TPS
#FLUX: -t=39600
#FLUX: --urgency=16

set -eu
main() {
    cd /lcrc/project/POLARIS/crossover/PILATES
    module_load
    setup_venv
    python3 ./run.py "$@"
}
setup_venv() {
    set +u; eval "$(conda shell.bash hook)"; set -u
    conda activate pilates
    # python3 -m pip install -r requirements.txt
}
module_load() {
    module load gcc/10.4.0-ckeolqi
    module load anaconda3
    module load singularity/3.10.2
    module load hdf5/1.12.1-l4cjxhb
}
main "$@"
