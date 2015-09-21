# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/bin

export PATH
export PATH=$PATH:/src/node-v0.12.7-linux-x64/bin/
export PATH=$PATH:/opt/src/apache-storm-0.9.4/bin/
export PATH=$PATH:/opt/src/redis-3.0.2/src/
