// *****************************************************************************
//
// File:        cosmos_db-containers.bicep
//
// Description: Creates Cosmos DB Containers.
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
param databaseAccountName string

@description('The name of the Database.')
param databaseName string

// Get the Cosmos DB Database Account.
resource databaseAccount 'Microsoft.DocumentDB/databaseAccounts@2024-05-15' existing = {
  name: databaseAccountName
}
// Get the Cosmos DB Database.
resource database 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases@2024-05-15' existing = {
  name: databaseName
  parent: databaseAccount
}

// Create a Cosmos DB Container for Exchange Rates.
resource exchangeRatesContainer 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers@2024-05-15' = {
  name: 'exchangeRates'
  parent: database
  properties: {
    resource: {
      id: 'exchangeRates'
      partitionKey: {
        kind: 'Hash'
        paths: [
          '/id'
        ]
      }
    }
  }
}

// Create a Cosmos DB Container for Expense Categories.
resource expenseCategoriesContainer 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers@2024-05-15' = {
  name: 'expenseCategories'
  parent: database
  properties: {
    resource: {
      id: 'expenseCategories'
      partitionKey: {
        kind: 'Hash'
        paths: [
          '/id'
        ]
      }
    }
  }
}

// Create a Cosmos DB Container for Expense Items.
resource expenseItemsContainer 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers@2024-05-15' = {
  name: 'expenseItems'
  parent: database
  properties: {
    resource: {
      id: 'expenseItems'
      partitionKey: {
        kind: 'Hash'
        paths: [
          '/expenseReportId'
        ]
      }
    }
  }
}

// Create a Cosmos DB Container for Expense Receipts.
resource expenseReceiptsContainer 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers@2024-05-15' = {
  name: 'expenseReceipts'
  parent: database
  properties: {
    resource: {
      id: 'expenseReceipts'
      partitionKey: {
        kind: 'Hash'
        paths: [
          '/expenseItemId'
        ]
      }
    }
  }
}

// Create a Cosmos DB Container for Expense Reports.
resource expenseReportsContainer 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers@2024-05-15' = {
  name: 'expenseReports'
  parent: database
  properties: {
    resource: {
      id: 'expenseReports'
      partitionKey: {
        kind: 'Hash'
        paths: [
          '/id'
        ]
      }
    }
  }
}

// Create a Cosmos DB Container for Expense Statuses.
resource expenseStatusesContainer 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers@2024-05-15' = {
  name: 'expenseStatuses'
  parent: database
  properties: {
    resource: {
      id: 'expenseStatuses'
      partitionKey: {
        kind: 'Hash'
        paths: [
          '/id'
        ]
      }
    }
  }
}

// Create a Cosmos DB Container for Expense Users.
resource expenseUsersContainer 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers@2024-05-15' = {
  name: 'expenseUsers'
  parent: database
  properties: {
    resource: {
      id: 'expenseUsers'
      partitionKey: {
        kind: 'Hash'
        paths: [
          '/id'
        ]
      }
    }
  }
}
