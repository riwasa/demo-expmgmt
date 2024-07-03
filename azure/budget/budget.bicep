// *****************************************************************************
//
// File:        budget.bicep
//
// Description: Creates a Budget and an Action Group for notifications.
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

@description('The e-mail address for the receiver.')
param actionGroupEmailAddress string

@description('The name of the receiver.')
param actionGroupEmailName string

@description('The name of the Action Group.')
param actionGroupName string

@description('The short name for the Action Group. Up to 12 characters in length.')
@maxLength(12)
param actionGroupShortName string

@description('The total amount of cost or usage to track.')
param amount int

@description('The name of the Budget.')
param budgetName string

@description('The end date for the budget in YYYY-MM-DD format. If not provided, this is defaulted to 10 years from the start date.')
param endDate string

@description('The threshold for the first notification. Percentage between 0 and 1000.')
param firstThreshold int

@description('The threshold for the second notification. Percentage between 0 and 1000.')
param secondThreshold int

@description('The start date for the budget as the first of the month in YYYY-MM-DD format. Future start date should not be more than three months. Past start date should be selected within the timegrain period.')
param startDate string

@description('The time covered by the Budget. Tracking will be reset based on the time grain.')
@allowed([
  'Monthly'
  'Quarterly'
  'Annually'
])
param timeGrain string = 'Monthly'

// Create an Action Group to receive notifications.
resource actionGroup 'Microsoft.Insights/actionGroups@2023-01-01' = {
  name: actionGroupName
  location: 'Global'
  properties: {
    emailReceivers: [
      {
        emailAddress: actionGroupEmailAddress
        name: actionGroupEmailName
        useCommonAlertSchema: true
      }
    ]
    enabled: true
    groupShortName: actionGroupShortName
  }
}

// Create a Budget.
resource budget 'Microsoft.Consumption/budgets@2023-11-01' = {
  name: budgetName
  properties: {
    amount: amount
    category: 'Cost'
    notifications: {
      NotificationForExceededBudget1: {
        contactEmails: []
        contactGroups: [
          actionGroup.id
        ]
        enabled: true
        operator: 'GreaterThan'
        threshold: firstThreshold
      }
      NotificationForExceededBudget2: {
        contactEmails: []
        contactGroups: [
          actionGroup.id
        ]
        enabled: true
        operator: 'GreaterThan'
        threshold: secondThreshold
      }
    }    
    timeGrain: timeGrain
    timePeriod: {
      startDate: startDate
      endDate: endDate
    }
  }
}
