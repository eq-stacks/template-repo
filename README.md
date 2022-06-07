# Template repo
> Reusable, mass-producible code scaffolding for EQ Stacks

<!--
  Enter project specific info here, following the "standard readme" format
  https://github.com/RichardLitt/standard-readme/blob/master/spec.md

  Keep the info below so people know how to set up using the scripts
-->

## Installation

This IaaS code assumes that you have a [Shared VPC](https://cloud.google.com/vpc/docs/shared-vpc) set up
in your Google Cloud organization, as well as a project that specifically contains your service account(s).

You will need the IDs of both of those projects to start.

## Prerequisites and Setup

1. Install the Google Cloud SDK
2. `gcloud auth login`
3. Get the service account information from your administrator and add it to your gcloud config

Then run:

```bash
$ ./scripts/add_sa_role.sh
```

This will give the service account the necessary permissions for one hour while you do your IaaS work.

## Structuring

This stack is structured in three modules, executed in following order:

1. Infrastructure module contains all cloud infrastructure configuration. It builds the stack to the point where Kubernetes API comes up.
2. Kubernetes module configures the basic cluster configurations. It sets defaults to storage classes and refines the k8s role bindings for Terraform service account.
3. Workload module configures the actual workload this stack is running on the k8s cluster. By default there is prometheus stack installed, but any more specific workload configuration goes here.

Additionally, there is `charts` directory that is meant to be used for embedded Helm charts which are hosted _in_ this repo. These can be then referenced from the workload configuration.
