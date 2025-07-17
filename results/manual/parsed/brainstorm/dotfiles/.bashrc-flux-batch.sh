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
export AWS_DEFAULT_PROFILE_ASSUME_ROLE='bastion_brainstorm'
export GITHUB_TOKEN='`cat $HOME/.github`'
export GOPATH='$HOME/go'
export IDF_PATH='~/dev/espressif/esp-idf'
export ESP_ROOT='~/esp8266/esp-open-sdk'
export ESPBAUD='921600'
export AMPY_PORT='/dev/cu.usbserial-FTYKHBJT'
export KISYSMOD='/usr/share/kicad/modules'
export USE_CCACHE='1'
export ANDROID_JACK_VM_ARGS='-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx3G'
export R2PM_DBDIR='$HOME/.r2pm'

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
	if [ -f $(brew --prefix)/etc/bash_completion ]; then
		source $(brew --prefix)/etc/bash_completion
	fi
else
	alias ls="ls --color"
	if [ -f /etc/bash_completion ]; then
    	source /etc/bash_completion
	fi
fi
complete -C aws_completer aws
source $(which assume-role)
export AWS_DEFAULT_PROFILE_ASSUME_ROLE="bastion_brainstorm"
function aws_account_info {
  [ "$AWS_ACCOUNT_NAME" ] && [ "$AWS_ACCOUNT_ROLE" ] && echo -n "aws:($AWS_ACCOUNT_NAME:$AWS_ACCOUNT_ROLE) "
}
PROMPT_COMMAND='aws_account_info'
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
export PATH=$PATH:/usr/lib/go-1.7/bin
alias drma="docker ps -aq --no-trunc | xargs docker rm"
alias dkd="docker run -d -P"
alias dki="docker run -t -i -P"
alias dco="docker-compose"
alias dpa="docker ps -a"
source <(kubectl completion bash)
source <(kompose completion bash)
export PATH=$PATH:$HOME/dev/espressif/crosstool-NG/builds/xtensa-esp32-elf/bin:~/.mos/bin
export PATH=$HOME/dev/espressif/esp-open-sdk/xtensa-lx106-elf/bin:$PATH
export IDF_PATH=~/dev/espressif/esp-idf
export ESP_ROOT=~/esp8266/esp-open-sdk
export ESPBAUD=921600
export AMPY_PORT=/dev/cu.usbserial-FTYKHBJT
alias slurm_template='echo "#!/bin/bash
" > slurm.sh'
export KISYSMOD="/usr/share/kicad/modules"
export USE_CCACHE=1
export ANDROID_JACK_VM_ARGS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx3G"
export PATH=$PATH:$HOME/.local/bin
export R2PM_DBDIR="$HOME/.r2pm"
PATH="$PATH:/Users/romanvg/.mos/bin"
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash ] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash ] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash
export PATH="$PATH:$HOME/.rvm/bin"
