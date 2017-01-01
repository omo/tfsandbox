# For pyenv
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# For cudann
export LD_LIBRRAY_PATH=/usr/local/cuda/lib64/
