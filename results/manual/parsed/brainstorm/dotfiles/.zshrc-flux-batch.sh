#!/bin/bash
#FLUX: --job-name=True
#FLUX: --queue=defq
#FLUX: -t=864000
#FLUX: --urgency=16

export GPG_TTY='$(tty)'
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8" '
export PATH='$PATH:$HOME/.rvm/bin'
export HISTSIZE='32768'
export HISTFILESIZE='$HISTSIZE'
export HISTCONTROL='ignoredups'
export GITHUB_TOKEN='`cat $HOME/.github`'
export GOPATH='$HOME/go'
export IDF_PATH='~/dev/espressif/esp-idf'
export ESP_ROOT='~/dev/esp8266/esp-open-sdk'
export ESPBAUD='921600'
export AMPY_PORT='/dev/cu.usbserial-FTYKHBJT'
export KISYSMOD='/Library/Application Support/kicad/modules/'
export KICAD_SYMBOL_DIR='/Library/Application Support/kicad/library'
export KICAD_PTEMPLATES='/Library/Application Support/kicad/template/'
export USE_CCACHE='1'
export ANDROID_JACK_VM_ARGS='-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx3G'
export R2PM_DBDIR='$HOME/.r2pm'

alias jsontidy="pbpaste | jq '.' | pbcopy"
export GPG_TTY=$(tty)
platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
   platform='osx'
fi
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8" 
export PATH="~/bin:$PATH"
export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL=ignoredups
if [[ "$platform" == 'osx' ]]; then
	alias ls="ls -G"
	alias removexattrs="chmod -RN . && xattr -c ."
	fi
else
	alias ls="ls --color"
	if [ -f /etc/bash_completion ]; then
    	source /etc/bash_completion
	fi
fi
alias ssoaws="aws-google-auth -d 43000 -a -I C03v1plyn -S 528518671174 -u roman.valls@umccr.org -p default && export AWS_PROFILE=default"
alias awsdev="pass show vccc/umccr.org | aws-google-auth -d 43000 -r arn:aws:iam::620123204273:role/dev-admin -I C03v1plyn -S 528518671174 -u roman.valls@umccr.org -p default && export AWS_PROFILE=default"
alias awsprod="pass show vccc/umccr.org | aws-google-auth -d 43000 -r arn:aws:iam::472057503814:role/prod-admin -I C03v1plyn -S 528518671174 -u roman.valls@umccr.org -p default && export AWS_PROFILE=default"
alias igplogin="pass show vccc/umccr-beta.login.illumina.com | igp login roman.vallsguimera@unimelb.edu.au -d umccr-beta | cat ~/.igp/.session.yaml | grep access-token | sed -e 's/access-token: //g'"
export GITHUB_TOKEN=`cat $HOME/.github`
alias assume-role-vault='. /usr/local/bin/assume-role-vault'
[ -f /Users/romanvg/.travis/travis.sh ] && source /Users/romanvg/.travis/travis.sh
if [[ "$platform" == 'linux' ]]; then
	export PATH="$HOME/.linuxbrew/bin:$PATH"
	export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
	export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"
	export CC=${CC:-`which gcc`} && export CXX=${CXX:-`which g++`}
	# Cannot be bothered to pass --env=inherit every time
	function brew {
		~/.linuxbrew/bin/brew "$@" --env=inherit;
	}
fi
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
alias drma="docker ps -aq --no-trunc | xargs docker rm"
alias dkd="docker run -d -P"
alias dki="docker run -t -i -P"
alias dco="docker-compose"
alias dpa="docker ps -a"
alias killallkube="kubectl delete secret,statefulset,pod,svc,rs,deploy,ingress,secret,configmap --all"
alias watchpods="watch kubectl get pods"
alias watchallpods="watch kubectl get pods --all-namespaces"
alias watchevents="kubectl get -w events"
alias watchsvc="kubectl get -w svc -o wide"
alias killallpods="kubectl delete pods --all"
alias ke="kubectl exec -it"
alias kl="kubectl logs -f"
alias kgs="kubectl get svc -o wide"
alias kgsa="kubectl get svc --all-namespaces -o wide"
alias kgp="kubectl get pod"
alias kgd="kubectl get deployment"
alias kgpa="kubectl get pod --all-namespaces"
export PATH=$PATH:$HOME/dev/espressif/xtensa-esp32-elf/bin:~/.mos/bin
export PATH=$HOME/dev/espressif/esp-open-sdk/xtensa-lx106-elf/bin:$PATH
export IDF_PATH=~/dev/espressif/esp-idf
. ${IDF_PATH}/add_path.sh
export ESP_ROOT=~/dev/esp8266/esp-open-sdk
export ESPBAUD=921600
export AMPY_PORT=/dev/cu.usbserial-FTYKHBJT
alias slurm_template='echo "#!/bin/bash
" > slurm.sh'
export KISYSMOD="/Library/Application Support/kicad/modules/"
export KICAD_SYMBOL_DIR="/Library/Application Support/kicad/library"
export KICAD_PTEMPLATES="/Library/Application Support/kicad/template/"
export USE_CCACHE=1
export ANDROID_JACK_VM_ARGS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx3G"
export PATH=$PATH:$HOME/.local/bin
export R2PM_DBDIR="$HOME/.r2pm"
export PATH=$PATH:/usr/local/ghidra
alias ghidra="ghidraRun"
export PATH="$PATH:$HOME/.rvm/bin"
[ -f /Users/romanvg/dev/umccr/htsget-aws/node_modules/tabtab/.completions/slss.bash ] && . /Users/romanvg/dev/umccr/htsget-aws/node_modules/tabtab/.completions/slss.bash
