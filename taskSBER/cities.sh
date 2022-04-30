#!/bin/bash
set -x -v

ansible-playbook playbk.yaml --extra-vars='{"cities": [Москва, Питер, Патонг, Паттайя, Джорджтаун, Сингапур]}' -v
