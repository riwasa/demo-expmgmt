# Azure Infrastructure-as-Code files

This folder contains Infrastructure-as-Code (IaC) scripts and templates to create Azure resources.

## Files

Folder | Description
------ | -----------
resource_group | Create the Resource Group.

## Instructions

1. Edit script_variables.ps1 and change the following
    - location and locationName to the desired Azure region.
    - resourceNamePrefix as a preface for all resource names.
    - resourceNameRawPrefix as a preface for all resource names that only allow alphanumeric characters, such as Storage Accounts.
2. Run resource_group\resource_group.ps1 to create the Resource Group.