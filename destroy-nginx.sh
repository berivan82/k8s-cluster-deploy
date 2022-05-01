#!/bin/bash
set -x -v
kubectl delete svc nginx
kubectl delete deploy nginx-deployment

