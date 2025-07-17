#!/bin/bash
#FLUX: --job-name=moolicious-muffin-0764
#FLUX: -c=20
#FLUX: --queue=eap
#FLUX: -t=3600
#FLUX: --urgency=16

for p in venv apex; do
    if [ -e "$p" ]; then
	read -n 1 -r -p "$p exists. OK to remove? [y/n] "
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
            echo "Removing $p."
	    rm -rf "$p"
	else
            echo "Exiting."
            exit 1
	fi
    fi
done
module --quiet purge
module load CrayEnv
module load PrgEnv-cray/8.3.3
module load craype-accel-amd-gfx90a
module load cray-python
module use /pfs/lustrep2/projappl/project_462000125/samantao-public/mymodules
module load suse-repo-deps/sam-default
module load rocm/sam-5.2.3.lua
module load rccl/sam-develop.lua
module load aws-ofi-rccl/sam-default.lua
python -m venv --system-site-packages venv
source venv/bin/activate
python -m pip install --upgrade pip setuptools wheel
python -m pip install --upgrade torch --extra-index-url https://download.pytorch.org/whl/rocm5.2/
python -m pip install --upgrade numpy datasets evaluate accelerate sklearn nltk
python -m pip install --upgrade git+https://github.com/huggingface/transformers
python -m pip install --upgrade deepspeed
git clone https://github.com/ROCmSoftwarePlatform/apex/
cd apex
git checkout 5de49cc90051adf094920675e1e21175de7bad1b
cd -
mkdir -p logs
cat <<EOF > install_apex.sh
module --quiet purge
module load CrayEnv
module load PrgEnv-cray/8.3.3
module load craype-accel-amd-gfx90a
module load cray-python
module use /pfs/lustrep2/projappl/project_462000125/samantao-public/mymodules
module load suse-repo-deps/sam-default
module load rocm/sam-5.2.3.lua
module load rccl/sam-develop.lua
module load aws-ofi-rccl/sam-default.lua
source venv/bin/activate
cd apex
python setup.py install --cpp_ext --cuda_ext
EOF
echo "Installing apex on a GPU node. This is likely to take around 30 min."
time sbatch --wait install_apex.sh
