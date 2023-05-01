#!/bin/zsh

mkdir -p ~/.config/nvim
cd $(dirname $0)
DIR=$(pwd)
ln -s ${DIR}/init.lua ~/.config/nvim/init.lua
ln -s ${DIR}/lua ~/.config/nvim/lua
