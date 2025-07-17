#!/bin/bash
#FLUX: --job-name={job_name}
#FLUX: --queue={queue}
#FLUX: --urgency=16

export PATH='/work/05622/lhq/stampede2/bin:$PATH'
export PYTHONPATH='/tmp/test_{env_dir_random}/envs/schicluster/lib/python3.8/site-packages'
export OMP_NUM_THREADS='48'

{email_str}
{email_type_str}
mkdir /tmp/test_{env_dir_random}
micromamba shell init -s bash -p /tmp/test_{env_dir_random}
source ~/.bashrc
micromamba activate
micromamba create -y -n schicluster python=3.8 numpy scipy scikit-learn h5py \
joblib cooler pandas statsmodels rpy2 anndata xarray snakemake pybedtools htslib=1.9 pysam=0.18
micromamba activate schicluster
pip install schicluster
which hicluster
date
hostname
pwd
for i in `seq 1 5`
do
{command} --batch summary=${{i}}/5
done
rm -rf /tmp/test*
