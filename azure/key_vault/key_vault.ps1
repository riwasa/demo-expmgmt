# *****************************************************************************
#
# File:        key_vault.ps1
#
# Description: Creates a Key Vault.
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

# Create a Key Vault.
Write-Host "Creating a Key Vault"

az deployment group create `
  --name "key_vault" `
  --resource-group "$resourceGroupName" `
  --template-file "key_vault.bicep" `
  --parameters "key_vault.parameters.json" `
  --parameters location="$location" `
               vaultName="$keyVaultName"