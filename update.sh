#!/usr/bin/env bash

for plugin in $(ls ./pack/plugins/start/); do
  git -C ./pack/plugins/start/${plugin} pull origin master
done

for plugin in $(ls ./pack/plugins/opt/); do
  git -C ./pack/plugins/opt/${plugin} pull origin master
done
