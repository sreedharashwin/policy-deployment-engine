This is a project to check compliance with the creation rules for Google Secure Source Manager.

Google Secure Source Manager is used for managing and securing code, configuration, and other resources within the Google Cloud ecosystem.

There are two files c.tf (compliant terraform rules) and nc.tf (non compliance terraform rules)

To run the policy check, we need to follow the below steps:

1. terraform init:
    To initialise Terraform with the Google Provider
2. terraform plan -var-file="terraform.tfvars" -out="plan.tfplan" 
    This will create a high level plan that Terraform will communicate with the provider to create resources using
    the configuration file (contains GCP credentials, region and project information)
3. terraform show -json "plan.tfplan" > "plan.json"
    This command will convert the tf.plan file into a JSON and saves this into a file. 
    OPA will work with this file by loading the contents into its engine as data model.
4. opa exec --decision terraform/analysis/authz tfplan.json
    opa exec command with the --decision terraform/analysis/authz --bundle . plan.json 
    option is used to execute an Open Policy Agent (OPA) policy decision based on a given 
    Terraform plan. It evaluates the decision rule defined at the path terraform/analysis/authz
    in the policy bundle located in the current directory (.). 
    OPA processes this input against the defined policy rules to determine whether the proposed actions (like adding, modifying, or deleting resources) are authorized according to the policy. The outcome of this evaluation is returned, 
    indicating whether the changes are allowed or denied based on the policy's conditions.

![Compliance Check](image.png)

![Non Compliance Check](image-1.png)