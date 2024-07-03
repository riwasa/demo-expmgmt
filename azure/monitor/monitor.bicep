// *****************************************************************************
//
// File:        log_analytics.bicep
//
// Description: Creates a Log Analytics Workspace and an Application Insights
//              Component.
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

@description('The name of the Application Insights Component.')
param applicationInsightsComponentName string

@description('The type of application being monitored.')
@allowed([
  'other'
  'web'
])
param applicationType string

@description('The daily quota for ingestion in GB.')
param dailyQuotaInGB int

@description('Indicates whether IP masking is disabled.')
param disableIpMasking bool

@description('Indicates whether non-Entra ID based authentication is disabled.')
param disableLocalAuth bool

@description('Indicates whether data can be exported.')
param enableDataExport bool

@description('Indicates whether permissions are applied at the workspace or resource level.')
param enableLogAccessUsingOnlyResourcePermissions bool

@description('The kind of application that this component refers to, used to customize UI.')
@allowed([
  'ios'
  'java'
  'other'
  'phone'
  'store'
  'web'
])
param kind string

@description('The location of the resources.')
param location string = resourceGroup().location

@description('The name of the Log Analytics Workspace.')
param logAnalyticsWorkspaceName string

@description('Indicates whether Log Analytics ingestion is accessible from the public internet.')
param publicNetworkAccessForIngestion string = 'Enabled'

@description('Indicates whether Log Analytics querying is accessible from the public internet.')
param publicNetworkAccessForQuery string = 'Enabled'

// Retention for Application Insights data types default to 90 days and will get the workspace
// retention if it is over 90 days. To set the retention on these types to be less than 90 days,
// set the retention on each of these data types.
@description('The number of days to retain data.')
param retentionInDays int

@description('The percentage of data produced by the application to sample for telemetry.')
param samplingPercentage int

// Create a Log Analytics Workspace.
resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2023-09-01' = {
  name: logAnalyticsWorkspaceName
  location: location
  properties: {
    features: {
      disableLocalAuth: disableLocalAuth
      enableDataExport: enableDataExport
      enableLogAccessUsingOnlyResourcePermissions: enableLogAccessUsingOnlyResourcePermissions
    }
    publicNetworkAccessForIngestion: publicNetworkAccessForIngestion
    publicNetworkAccessForQuery: publicNetworkAccessForQuery
    retentionInDays: retentionInDays
    sku: {
      name: 'PerGB2018'
    }
    workspaceCapping: {
      dailyQuotaGb: dailyQuotaInGB
    }
  }
}

// Create an Application Insights Component.
resource applicationInsightsComponent 'Microsoft.Insights/components@2020-02-02' = {
  name: applicationInsightsComponentName
  location: location
  kind: kind
  properties: {
    Application_Type: applicationType
    DisableIpMasking: disableIpMasking
    DisableLocalAuth: disableLocalAuth
    Flow_Type: 'Bluefield'
    IngestionMode: 'LogAnalytics'
    publicNetworkAccessForIngestion: publicNetworkAccessForIngestion
    publicNetworkAccessForQuery: publicNetworkAccessForQuery
    Request_Source: 'rest'
    RetentionInDays: retentionInDays
    SamplingPercentage: samplingPercentage
    WorkspaceResourceId: logAnalyticsWorkspace.id
  }
}
