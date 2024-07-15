// *****************************************************************************
//
// File:        cosmos_db.bicep
//
// Description: Creates a Cosmos DB Database Account and Database.
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

@description('The name of the Database Account.')
@minLength(3)
@maxLength(44)
param databaseAccountName string

@description('The name of the Database.')
param databaseName string

@description('The log categories to capture.')
@allowed([
  'DataPlaneRequests'
  'MongoRequests'
  'QueryRuntimeStatistics'
  'PartitionKeyStatistics'
  'PartitionKeyRUConsumption'
  'ControlPlaneRequests'
  'CassandraRequests'
  'GremlinRequests'
  'TableApiRequests'
])
param diagnosticsLogCategoriesToEnable array = [
  'DataPlaneRequests'
  'MongoRequests'
  'QueryRuntimeStatistics'
  'PartitionKeyStatistics'
  'PartitionKeyRUConsumption'
  'ControlPlaneRequests'
  'CassandraRequests'
  'GremlinRequests'
  'TableApiRequests'
]

@description('The metrics to capture.')
@allowed([
  'Requests'
])
param diagnosticsMetricsToEnable array = [
  'Requests'
]

@description('The location of the resources.')
param location string

@description('The name of the location of the resources.')
param locationName string

@description('The name of the Log Analytics Workspace.')
param logAnalyticsWorkspaceName string

var diagnosticsLogs = [for category in diagnosticsLogCategoriesToEnable: {
  category: category
  enabled: true
}]

var diagnosticsMetrics = [for metric in diagnosticsMetricsToEnable: {
  category: metric
  timeGrain: null
  enabled: true
}]

// Get the Log Analytics Workspace.
resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2023-09-01' existing = {
  name: logAnalyticsWorkspaceName
}

// Create a Cosmos DB Database Account.
resource databaseAccount 'Microsoft.DocumentDB/databaseAccounts@2024-05-15' = {
  name: databaseAccountName
  location: location
  kind: 'GlobalDocumentDB'
  properties: {
    backupPolicy: {
      type: 'Continuous'
    }
    capabilities: [
      {
        name: 'EnableServerless'
      }
    ]
    consistencyPolicy: {
      defaultConsistencyLevel: 'Session'
    }
    databaseAccountOfferType: 'Standard'
    enableAutomaticFailover: false
    enableFreeTier: false
    locations: [
      {
        failoverPriority: 0
        locationName: locationName
      }
    ]
  }
  tags: {
    defaultExperience: 'Core (SQL)'
  }
}

// Create diagnostic settings.
resource diagnosticSettings 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: '${databaseAccountName}-diag'
  properties: {
    logs: diagnosticsLogs
    metrics: diagnosticsMetrics
    workspaceId: logAnalyticsWorkspace.id
    logAnalyticsDestinationType: 'Dedicated'
  }
  scope: databaseAccount
}

// Create a Cosmos DB Database.
resource database 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases@2024-05-15' = {
  name: databaseName
  parent: databaseAccount
  properties: {
    resource: {
      id: databaseName
    }
  }
}
