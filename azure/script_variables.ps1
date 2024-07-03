# *****************************************************************************
#
# File:        script_variables.ps1
#
# Description: Sets variables used in other scripts.
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

# ***********************************************
# Global values.
# ***********************************************

# Azure region.
$location = "westus"
$locationName = "West US"

# Resource name prefix.
$resourceNamePrefix = "rim-demo-expmgmt"
$resourceNameRawPrefix = "rimdemoexpmgmt"

# Resource Group name.
$resourceGroupName = "$($resourceNamePrefix)-rg"

# ***********************************************
# Resource values.
# ***********************************************

# Budget.
$actionGroupName = "$($resourceNamePrefix)-ag"
$actionGroupShortName = "demo-expmgmt"
$budgetName = "$($resourceNamePrefix)-bdgt"

# Key Vault.
$keyVaultName = "$($resourceNamePrefix)-kv"

# Monitor.
$applicationInsightsComponentName = "$($resourceNamePrefix)-appi"
$logAnalyticsWorkspaceName = "$($resourceNamePrefix)-log"
