#!/bin/bash

set -ex

ORG_ID=$(gcloud organizations list --format 'value(ID)')
EXPIRY=$(python3 -c 'from datetime import datetime, timedelta; now = datetime.utcnow(); expires = now + timedelta(hours=1); print(expires.strftime("%Y-%m-%dT%H:%M:%SZ"))')
SA_PROJECT=$(gcloud config get-value project)
SERVICE_ACCOUNT="terraform@$SA_PROJECT.iam.gserviceaccount.com"

gcloud organizations add-iam-policy-binding "$ORG_ID" \
  --member="serviceAccount:$SERVICE_ACCOUNT" \
  --role "organizations/$ORG_ID/roles/terraformServiceAccount" \
  --condition="expression=request.time < timestamp('$EXPIRY'),title=Expiry: $EXPIRY"
