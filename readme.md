# Github Actions with Terraform

This simple project uses Github Actions with Terraform.
One of the first things I wanted to do when starting to work with Terraform in Actions is to control what version of Terraform was being installed on the Actions runner. I like to keep my Terraform versions as current as possible however it is nice to have the ability to control the specific versions if needed.
The setup-terraform actions project by Hashicorp allows the definition in the workflow but I wanted to find a way to sync it with the version defined in the main.tf file. The solution to this was a fairly simple `awk` statement that finds the `require_version` text in the main.tf file and then trims the quotation marks.

```
- name: Get Terraform Module version
  id: tf_version
  run: |
    echo "::set-output name=TF_VERSION::$(awk '/required_version/{print $NF}' ./main.tf | tr -d \")"
```

The output is then used by the hashicorp/setup-terraform@v1 action to setup the required version.

```
- name: Install Terraform
  id: tf_install
  uses: hashicorp/setup-terraform@v1
  with:
    terraform_version: ${{ steps.tf_version.outputs.TF_VERSION }}
```
