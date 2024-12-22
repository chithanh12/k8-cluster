#!/bin/bash
NEW_SLOT=$1
OLD_SLOT='green'
if [[ $NEW_SLOT == 'blue' ]]; then
	echo "[INFO] Disable plugin as the new_slot is blue..."
	echo "[INFO] Patching iam service to the new slot[blue] ..."
    kubectl -ndev scale --replicas 3 deployment dev-iam-blue
	kubectl patch svc iam -n dev --type='json' -p='[{"op": "replace", "path": "/spec/selector/slot", "value":"blue"}]'
else
    OLD_SLOT='blue'
    kubectl -ndev scale --replicas 3 deployment dev-iam-green
	echo "[INFO] Patching ${k8sServiceName} service to the new slot[green]..."
	kubectl patch svc iam -n dev --type='json' -p='[{"op": "replace", "path": "/spec/selector/slot", "value":"green"}]'
fi

kubectl -ndev scale --replicas 0 deployment dev-iam-${OLD_SLOT}