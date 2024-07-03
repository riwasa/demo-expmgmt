# Azure Infrastructure-as-Code files

This folder contains Infrastructure-as-Code (IaC) scripts and templates to create Azure resources.

## Files

Folder | Description
------ | -----------
budget | Create a Budget.
key_vault | Create a Key Vault.
monitor | Create a Log Analytics Workspace and an Application Insights Component.
resource_group | Create the Resource Group.

## Instructions

1. Edit script_variables.ps1 and change the following
    - location and locationName to the desired Azure region.
    - resourceNamePrefix as a preface for all resource names.
    - resourceNameRawPrefix as a preface for all resource names that only allow alphanumeric characters, such as Storage Accounts.
2. Run resource_group\resource_group.ps1 to create the Resource Group.
3. Create a Budget.
    - Update script_variables.ps1 and change the $actionGroupShortName.
    - Edit budget\budget.parameters.json as needed.
    - Run budget\budget.ps1 to create the Budget.
4. Create a Key Vault.
    - Update key_vault\key_vault.parameters.json as needed.
    - Run key_vault\key_vault.ps1 to create the Key Vault.
5. Create a Log Analytics Workspace and an Application Insights Component.
    - Update monitor\monitor.parameters.json as needed.
    - Run monitor\monitor.ps1 to create the Log Analytics Workspace and the Application Insights Component.