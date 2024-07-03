// *****************************************************************************
//
// File:        key_vault.bicep
//
// Description: Creates a Key Vault.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//
// *****************************************************************************

@description('Indicates if Azure VMs are allowed to retrieve certificates stored as secrets.')
param enabledForDeployment bool

@description('Indicates if Azure Disk Encryption is allowed to retrieve secrets and unwrap keys.')
param enabledForDiskEncryption bool

@description('Indicates if Azure Resource Manager is allowed to retrieve secrets.')
param enabledForTemplateDeployment bool

@description('Indicates if purge protection should be enabled for the Key Vault and secrets.')
param enablePurgeProtection bool

@description('Indicates if RBAC should be used to authorize data actions.')
param enableRbacAuthorization bool

@description('The location of the resources.')
param location string = resourceGroup().location

@description('Indicates if public network access is allowed.')
@allowed([
  ''
  'Disabled'
  'Enabled'
])
param publicNetworkAccess string = ''

@description('The name of the SKU.')
@allowed([
  'premium'
  'standard'
])
param skuName string

@description('The number of days that the Key Vault will be retained when it is soft deleted.')
@minValue(7)
@maxValue(90)
param softDeleteRetentionInDays int = 7

@description('The name of the Key Vault.')
param vaultName string

// Create a Key Vault.
resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: vaultName
  location: location
  properties: {
    enabledForDeployment: enabledForDeployment
    enabledForDiskEncryption: enabledForDiskEncryption
    enabledForTemplateDeployment: enabledForTemplateDeployment
    enablePurgeProtection: enablePurgeProtection ? enablePurgeProtection : null
    enableRbacAuthorization: enableRbacAuthorization
    enableSoftDelete: true
    publicNetworkAccess: !empty(publicNetworkAccess) ? any(publicNetworkAccess) : null
    sku: {
      family: 'A'
      name: skuName
    }
    softDeleteRetentionInDays: softDeleteRetentionInDays
    tenantId: subscription().tenantId
  }
}
