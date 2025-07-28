#!/bin/bash
#FLUX: --job-name=eval
#FLUX: -c=8
#FLUX: --queue=all
#FLUX: -t=345600
#FLUX: --urgency=16

pc=sppc1
if [ "$pc" = sppc1 ]; then
    data_dir=/data/lemercier/databases
    home_dir=/export/home/lemercier
elif [ "$pc" = spgpu1 ]; then
    data_dir=/data/lemercier/databases
    home_dir=/data1/lemercier
elif [ "$pc" = spgpu2 ]; then
    data_dir=/data3/lemercier/databases
    home_dir=/export/home/lemercier
fi;
test_dir="$data_dir/vctk_derev_with_rir/audio/tt/noisy"
rir_dir="$data_dir/vctk_derev_with_rir/rir/tt"
ckpt_score="/export/home/lemercier/code/_public_repos/derevdps/.logs/sde=EDM_backbone=ncsnpp_data=vctk_pretarget/version_1/checkpoints/epoch=253.ckpt"
n=2
N=200
scheduler="edm"
zeta=7
r=0.4
alpha=1
beta=0.1
pre="karras"
sde="edm"
zeta_schedule="div-sig"
sampler_type="karras"
predictor="euler-heun-dps"
corrector="none"
posterior="none"
python3 enhancement.py \
    --test_dir $test_dir --rir_dir $rir_dir \
    --N $N --n $n --sampler_type $sampler_type --scheduler $scheduler \
    --predictor $predictor \
    --corrector $corrector --r $r \
    --posterior $posterior --operator reverberation --zeta $zeta --zeta_schedule $zeta_schedule \
    --ckpt $ckpt_score \
    --enhanced_dir .exp/.posterior/prior=0_${sampler_type}_sde=${sde}_pre=${pre}_alpha=${alpha}_beta=${beta}_N=${N}_pred=${predictor}_corr=${corrector}_r=${r}_sched=${scheduler}_post=${posterior}_zeta=${zeta}_zsched=${zeta_schedule}
