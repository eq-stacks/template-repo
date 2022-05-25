#!/bin/bash

set -x

ORG_ID=$(gcloud organizations list --format 'value(ID)')
TIMESTAMP=$(date +%s)
DELTA=3000
TIMESTAMP_PLUS_EXPIRY=$((TIMESTAMP + DELTA))
EXPIRY=$(printf '%(%Y-%m-%dT%H:%M:%SZ)T' $TIMESTAMP_PLUS_EXPIRY)
SA_PROJECT=$(gcloud config get-value project)
SERVICE_ACCOUNT="terraform@$SA_PROJECT.iam.gserviceaccount.com"

gcloud organizations add-iam-policy-binding "$ORG_ID" \
  --member="serviceAccount:$SERVICE_ACCOUNT" \
  --role "organizations/$ORG_ID/roles/terraformServiceAccount" \
  --condition="expression=request.time < timestamp('$EXPIRY'),title=Expiry: $EXPIRY"
