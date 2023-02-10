Terraform 101
=============


Main commands:
-------------
*  init          Prepare your working directory for other commands
*  validate      Check whether the configuration is valid
*  plan          Show changes required by the current configuration
*  apply         Create or update infrastructure
*  destroy       Destroy previously-created infrastructure


All other commands:
-------------------
*  console       Try Terraform expressions at an interactive command prompt
*  fmt           Reformat your configuration in the standard style
*  force-unlock  Release a stuck lock on the current workspace
*  get           Install or upgrade remote Terraform modules
*  graph         Generate a Graphviz graph of the steps in an operation
*  import        Associate existing infrastructure with a Terraform resource
*  login         Obtain and save credentials for a remote host
*  logout        Remove locally-stored credentials for a remote host
*  output        Show output values from your root module
*  providers     Show the providers required for this configuration
*  refresh       Update the state to match remote systems
*  show          Show the current state or a saved plan
*  state         Advanced state management
*  taint         Mark a resource instance as not fully functional
*  untaint       Remove the 'tainted' state from a resource instance
*  version       Show the current Terraform version
*  workspace     Workspace management
*  reference - https://www.terraform.io/docs/cli/commands/state/show.html 

Options
--------
Global options (use these before the subcommand, if any):
  -chdir=DIR    Switch to a different working directory before executing the
                given subcommand.
  -help         Show this help output, or the help for a specified subcommand.
  -version      An alias for the "version" subcommand.


How-to:
-------
* How to pass variables example:
  - terraform plan --var-file="./sample1.tf.vars" --out myplan

* How to apply with auto-approve:
  - terraform apply --var-file="./sample1.tf.vars" -auto-approve

* How to apply a generated plan 
  - terraform apply "myplan" -auto-approve


What is tained in Terraform
---------------------------
* When a resource is not created completed as planned, it is listed as tained resource. manually this resource can be corrected in statefile to using tain and untain commands.
  - Ref: https://www.devopsschool.com/blog/terraform-taint-and-untaint-explained-with-example-programs-and-tutorials/ 


Useful references for good understanding
----------------------
* Using complex variables:   https://blog.wimwauters.com/devops/2022-03-01_terraformusecases/ 
* Using Loops: https://blog.gruntwork.io/terraform-tips-tricks-loops-if-statements-and-gotchas-f739bbae55f9
  
Terraform Misc 
-------------
* How to handle a Locked state file 
  * `terraform force-unlock [options] LOCK_ID` command can be used to unlock
  * Useful reference: https://buildvirtual.net/terraform-error-locking-state/#:~:text=This%20is%20done%20using%20the,really%20want%20to%20force%2Dunlock%3F
  * What if the file is in Azure, you use it only using Automated Pipelines 
    * One of the option is to open the file in portal and use `Break Lease` option.
      * ..
    * This can also be done using Cmdlets (Ref: https://www.kondaurov.me/2022/unlock-terraform-state-on-azure-storage/) 
