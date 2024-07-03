# *****************************************************************************
#
# File:        budget.ps1
#
# Description: Creates a Budget and an Action Group for notifications.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
# *****************************************************************************

# Get script variables.
. $PSScriptRoot\..\script_variables.ps1

# Set the start date and the end date for the budget, using a period
# from the 1st of the current month to 2 years in the future.
$startDate = Get-Date -Day 1
$startDateString = $startDate.ToString("yyyy-MM-dd")
$endDate = $startDate.AddYears(2)
$endDateString = $endDate.ToString("yyyy-MM-dd")

Write-Host "Start Date: $startDateString End Date: $endDateString"

# Create a Budget and an Action Group.
$adminName = Read-Host "Enter the name of the administrator"
$adminEmail = Read-Host "Enter the email of the administrator"

Write-Host "Administator name: $adminName"
Write-Host "Administator email: $adminEmail"

$confirm = Read-Host "Are these values correct? (Y/n)"

# if $confirm is empty or "Y", then create the Budget and Action Group.
if ([string]::IsNullOrEmpty($confirm) -or $confirm -eq "Y" -or $confirm -eq "y") {
  Write-Host "Creating a Budget and an Action Group"

  az deployment group create `
    --name "budget" `
    --resource-group "$resourceGroupName" `
    --template-file "budget.bicep" `
    --parameters "budget.parameters.json" `
    --parameters actionGroupName="$actionGroupName" `
                 actionGroupShortName="$actionGroupShortName" `
                 actionGroupEmailAddress="$adminEmail" `
                 actionGroupEmailName="$adminName" `
                 budgetName="$budgetName" `
                 endDate="$endDateString" `
                 startDate="$startDateString"
}
