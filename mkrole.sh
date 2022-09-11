#!/usr/bin/env bash

echo $1

if [ -n "$1" ]; then
  mkdir -p "$(pwd)/ansible/roles/$1"
  mkdir -p "$(pwd)/ansible/roles/$1/defaults"
  mkdir -p "$(pwd)/ansible/roles/$1/files"
  mkdir -p "$(pwd)/ansible/roles/$1/handlers"
  mkdir -p "$(pwd)/ansible/roles/$1/meta"
  mkdir -p "$(pwd)/ansible/roles/$1/tasks"
  mkdir -p "$(pwd)/ansible/roles/$1/templates"
  mkdir -p "$(pwd)/ansible/roles/$1/tests"
  mkdir -p "$(pwd)/ansible/roles/$1/vars"
fi
