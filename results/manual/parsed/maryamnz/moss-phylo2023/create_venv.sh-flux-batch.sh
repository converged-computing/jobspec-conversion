#!/bin/bash
#FLUX: --job-name=gassy-car-9299
#FLUX: -t=1800
#FLUX: --urgency=16

if [[ ! -d moss_phylo ]] ; then 
echo Making functional term transformers test environment [ moss_phylo ]
echo Can install environment modules using easybuild
module load MAFFT/7.505-GCC-11.3.0-with-extensions FastTree/2.1.11-GCCcore-11.3.0 BLAST+/2.13.0-gompi-2022a MCL/22.282-GCCcore-11.3.0 phyx/1.3-foss-2022a Cython/0.29.33-GCCcore-11.3.0 Python/2.7.18-GCCcore-11.3.0-bare
echo Python should be from Python/2.7
python --version
virtualenv moss_phylo
source moss_phylo/bin/activate
pip install pysqlite networkx clint
pip freeze | cut -f 1 -d ' ' | column
deactivate # leave virtual environent
module purge
module restore
fi
cat <<EOF | tee moss_phylo_stub.srun
module load MAFFT/7.505-GCC-11.3.0-with-extensions FastTree/2.1.11-GCCcore-11.3.0 BLAST+/2.13.0-gompi-2022a MCL/22.282-GCCcore-11.3.0 phyx/1.3-foss-2022a Cython/0.29.33-GCCcore-11.3.0 Python/2.7.18-GCCcore-11.3.0-bare
source ${PWD}/moss_phylo/bin/activate
EOF
cat <<"EOF" | tee -a moss_phylo_stub.srun
python --version
EOF
