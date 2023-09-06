# Templating this repository

Select "Use This Template" and create a repository within the organisation required. 
Decide if you are using the microsoft TRE or if your using a local fork.  
We recommend a fork so create a fork in your organisation of https://github.com/microsoft/AzureTRE (AzureTRE)  


## Prerequisits. 

You will need VSCODE and DOCKER installed locally.  
You will need a Personal Access Token created for GIT. You can do this via the UI. (PAT)  
Create a new resource group in the subscription your deploying to.   
Create an empty image galary inside that resource group and make note of the resource id. (GAL_ID)   
Edit .devcontainer/devcontainer.json and ensure your putting the correct TAG version e.g. "OSS_VERSION": "v0.14.1"  
Edit .devcontainer/scripts/install-azure-tre-oss.sh and ensure the org is correct http://github.com/(AzureTRE)/AzureTRE/archive/${oss_version}.tar.gz  


### Prerequisites

To work with devcontainers you will need:

- [Visual Studio Code](https://code.visualstudio.com)
- [Remote containers extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

## Contributing

This project welcomes contributions and suggestions.  Most contributions require you to agree to a
Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us
the rights to use your contribution. For details, visit <https://cla.opensource.microsoft.com>.

When you submit a pull request, a CLA bot will automatically determine whether you need to provide
a CLA and decorate the PR appropriately (e.g., status check, comment). Simply follow the instructions
provided by the bot. You will only need to do this once across all repos using our CLA.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

## Trademarks

This project may contain trademarks or logos for projects, products, or services. Authorized use of Microsoft
trademarks or logos is subject to and must follow
[Microsoft's Trademark & Brand Guidelines](https://www.microsoft.com/en-us/legal/intellectualproperty/trademarks/usage/general).
Use of Microsoft trademarks or logos in modified versions of this project must not cause confusion or imply Microsoft sponsorship.
Any use of third-party trademarks or logos are subject to those third-party's policies.
