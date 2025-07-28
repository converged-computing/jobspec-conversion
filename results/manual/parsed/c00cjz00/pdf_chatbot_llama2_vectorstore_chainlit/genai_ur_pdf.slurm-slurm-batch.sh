#!/bin/bash
#FLUX: --job-name=_t2g_
#FLUX: -c=4
#FLUX: --queue=gp4d
#FLUX: -t=3600
#FLUX: --urgency=16

iam=$(whoami)
charbot_dir=/work/${iam}/chainlit_demo
home_dir=${charbot_dir}/home
tmp_dir=${charbot_dir}/tmp
mkdir -p ${home_dir} ${tmp_dir}
rsync -avHS /work/u00cjz00/slurm_jobs/github/pdf_chatbot_llama2_vectorstore_chainlit/ ${charbot_dir}/home/pdf_chatbot_llama2_vectorstore_chainlit
IMAGE="/work/u00cjz00/nvidia/pytorch_2.1.0-cuda11.8-cudnn8-devel.sif"
noed_hostname=$(hostname -s)
noed_port=$(python3 /work/u00cjz00/binary/availablePort.py)
node_ip=$(cat /etc/hosts |grep "$(hostname -a)" | awk '{print $1}')
echo ""
echo ""
echo "****************************** 請輸入下方指令 ******************************"
echo ""
echo "# STEP1: Execute cmd in your client below "
echo ssh -L ${noed_port}:${noed_hostname}:${noed_port} ${iam}@ln01.twcc.ai
echo ""
echo "# STEP2: Open url below "
echo "http://localhost:${noed_port}/"
echo ""
echo ""
echo "***********************************************************************************************"
ps aux | grep chainlit | awk '{print $2}' | xargs kill -9 
ml libs/singularity/3.10.2
singularity exec --nv --no-home -B ${home_dir}:/home -B ${tmp_dir}:/tmp -B /work ${IMAGE} bash -c "cd /home/pdf_chatbot_llama2_vectorstore_chainlit && pip install -r requirements.txt -q"
singularity exec --nv --no-home -B ${home_dir}:/home -B ${tmp_dir}:/tmp -B /work ${IMAGE} bash -c "cd /home/pdf_chatbot_llama2_vectorstore_chainlit &&  pip install auto-gptq --extra-index-url https://huggingface.github.io/autogptq-index/whl/cu118/ -q"
singularity exec --nv --no-home -B ${home_dir}:/home -B ${tmp_dir}:/tmp -B /work -B ${PDF_FOLDER}:/home/pdf_chatbot_llama2_vectorstore_chainlit/data ${IMAGE} bash -c "cd /home/pdf_chatbot_llama2_vectorstore_chainlit && python3 ingest.py"
singularity exec --nv --no-home -B ${home_dir}:/home -B ${tmp_dir}:/tmp -B /work -B ${PDF_FOLDER}:/home/pdf_chatbot_llama2_vectorstore_chainlit/data ${IMAGE} bash -c "cd /home/pdf_chatbot_llama2_vectorstore_chainlit && ~/.local/bin/chainlit run model_gptq.py --port ${noed_port} --host ${noed_hostname}" &
pid0=$!
sleep 2
pid1=$(pgrep -P ${pid0})
pid=${pid1}
wait $pid0
