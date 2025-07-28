#!/bin/bash
#FLUX: --job-name=SDWebUI
#FLUX: --queue=gpu
#FLUX: -t=14400
#FLUX: --urgency=16

export 'PYTORCH_CUDA_ALLOC_CONF='max_split_size_mb:128'

date;hostname;pwd
module r webui
source venv/bin/activate
unset XDG_RUNTIME_DIR
unset LD_LIBRARY_PATH
export 'PYTORCH_CUDA_ALLOC_CONF=max_split_size_mb:128'
port=$(shuf -i 20000-30000 -n 1)
echo -e "\nStarting Stable Diffusion WebUI on port ${port} on the $(hostname) server."
echo -e "\nSSH tunnel command:"
echo -e "\tssh -NL ${port}:$(hostname):${port} ${USER}@hpg.rc.ufl.edu"
echo -e "\nLocal browser URI:"
echo -e "\thttp://127.0.0.1:${port}"
host=$(hostname)
python launch.py --listen --port ${port} --gradio-auth USERNAME:PASSWD --disable-safe-unpickle --enable-insecure-extension-access --lowram --xformers
