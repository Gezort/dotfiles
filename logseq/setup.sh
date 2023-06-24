#!/bin/zsh

mkdir -p ~/.logseq
cd $(dirname $0)
DIR=$(pwd)
ln -s ${DIR}/config ~/.logseq/config
ln -s ${DIR}/settings ~/.logseq/settings
