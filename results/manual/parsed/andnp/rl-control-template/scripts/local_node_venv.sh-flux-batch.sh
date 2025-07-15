#!/bin/bash
#FLUX: --job-name=hello-bicycle-8623
#FLUX: -t=3300
#FLUX: --urgency=16

module load python/3.11 rust
cp $path/requirements.txt $SLURM_TMPDIR/
cd $SLURM_TMPDIR
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
curl https://files.pythonhosted.org/packages/38/9c/3a3a831bfbd30fdedd61994d35df41fd0d47145693fe706976589214f811/connectorx-0.3.2-cp311-cp311-manylinux_2_28_x86_64.whl --output connectorx-0.3.2-cp311-cp311-linux_x86_64.whl
pip install connectorx-0.3.2-cp311-cp311-linux_x86_64.whl
tar -cavf venv.tar.xz .venv
cp venv.tar.xz $path/
pip freeze
