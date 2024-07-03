# *****************************************************************************
#
# File:        resource_group.ps1
#
# Description: Creates the Resource Group.
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

# Create the Resource Group.
Write-Host "Creating the Resource Group"

az deployment sub create `
  --name "$($resourceNamePrefix)_$($location)_resource_group" `
  --location $location `
  --template-file "resource_group.bicep" `
  --parameters name="$resourceGroupName" `
               location="$location"