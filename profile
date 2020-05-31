if [[ "$OSTYPE" == "darwin"* ]]; then
  export LC_ALL=en_US.UTF-8
  export LANG=en_US.UTF-8
else
  export LC_ALL=en_US.UTF-8
  export LANG=en_US.UTF-8
fi
source ~/.bashrc

export PATH="$HOME/.cargo/bin:$PATH"
_byobu_sourced=1 . /usr/bin/byobu-launch 2>/dev/null || true
