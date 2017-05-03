## Scripts that use Puppet APIs

- create_deploy: Create the PE console user deploy. Uses datafile user_deploy.json
- create_token: Create an auth token
- create_vcs_group: Create a classification group. Uses datafile vcs_group.json
- deploy_code: Deploys the control-repo using code manager
- setup_ad: Binds the console to Active Directory. Uses datafile ad.json
- update_classes: Refreshes the classes list in the PE console
- update_environments: Clears the environment cache
- wait_for_puppet: Checks if Puppet agent is running, and returns the prompt once the run is over

