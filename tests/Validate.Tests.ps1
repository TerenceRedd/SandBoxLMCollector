[CmdletBinding()]
param (
    [Parameter()]
    [ValidateSet("tst", "dev", "uat", "prd", "pdr", "npd")]
    [string]
    $Environment = "tst"
)

terraform init -backend=false | out-null
terraform validate | out-null

if ($LASTEXITCODE -ne 0) {
    $syntaxValid = $false
} else {
    $syntaxValid = $true
}

terraform init -backend-config="./config/backend/$Environment.tf"
if (terraform workspace list | select-string $Environment) {
    terraform workspace select $Environment
} else {
    terraform workspace new $Environment
}

terraform plan -refresh=true -input=false -var-file="./config/vars/$Environment.tfvars" -out="./$Environment.tfplan"

if (Test-Path "./$Environment.tfplan") {
    $planValid = $true
} else {
    $planValid = $false
}

Describe "Terraform" {
    It "has valid syntax" {
        $syntaxValid | Should Be $true
    }
    It "creates a valid plan for $Environment environment" {
        $planValid | Should Be $true
    }
}
