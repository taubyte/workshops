This DevContainer (Code Space) offers an easy way to develop or deploy a Cloud Computing Platform/Network using VS Code or GitHub.

# What's included
After launching the space, which can be easily achieved by clicking the Code button and selecting the Codespaces tab on GitHub, you'll have access to:

- Developer Tools:
  - tau: The Taubyte command-line interface
  - dreamland: Tools to create a local cloud environment for testing
- Ops Tools:
  - spore-drive: A command-line tool to simplify building a Cloud Computing Platform.

# Using Developer Tools:
For information on using the developer tools, please consult the [Documentation](https://tau.how/guides/build/02-guide/01-create-project/).

# Deploying your own Cloud!
To deploy your own cloud, you'll be using `spore-drive`.

## Watch Video

[![](https://img.youtube.com/vi/mXHEjjkF49s/hqdefault.jpg)](https://www.youtube.com/watch?v=mXHEjjkF49s)

## Steps
### Create A Network
1. Run `spore-drive new network` 
2. Enter the network name
3. Enter the network URL 
4. Select swarm key option (Choose 'Generate' for this walkthrough)
5. Enter the generated domain (ideally, it should be a subdomain of your network URL, like `g.example.com`)
6. Select the domain validation key Option (Choose 'Generate' for this walkthrough)
7. Enter any validation URL/regex skips. Any URLs/regex given will bypass any checks/validation and will serve them normally

You can view your current network by running `spore-drive current`.

### Create A Key For SSH
1. Run `spore-drive new key`
2. Enter the name
3. Enter the username for ssh
4. Enter the ssh key (either drag and drop the file or provide the local path; note that the path starting with ~ is not accepted). Make sure to remove any extra spaces at the end, if any

### Create a shape
Creating a shape with no protocols, called an "elder," is useful as a main bootstrapper to help nodes connect to each other.
1. Run `spore-drive new shape`
2. Enter a name
3. Select Protocols
4. Enter the ports to run nodes on (main, lite, IPFS). Depending on the protocols selected, you'll be asked for different ports

### Create a host
1. Run `spore-drive new host`
2. Enter a name
3. Enter the IP of the VM/server
4. Choose if it's the same as public address. If false, you must provide the public address
5. Enter any additional address IP/CIDR (any private IPs)
6. Enter the SSH Port (defaults to 22 if empty)
7. Select the corresponding key for the VM to ssh
8. Enter Latitude, Longitude (optional)
9. Select shapes to deploy on host
10. Select Shapes to add to the network bootstrap. All nodes will connect to these nodes in the bootstrap

### Setting up monkey to build
Monkey requires Docker to build jobs correctly. Download Docker and refer to: [Ubuntu Install Docker](https://docs.docker.com/engine/install/ubuntu/)

### Setting up DNS for seer
DNS needs to be freed up for seer to start properly. Follow these steps to adjust DNS settings:

1. Open `/etc/systemd/resolved.conf` with a text editor (nano, vim)
2. Set DNS=1.1.1.1 and DNSStubListener=no
3. Run `systemctl restart systemd-resolved.service`
4. Run `ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf`

### Deploy your network
After setting up all of the above, you can now deploy the network by running `spore-drive deploy -s shape1,shape2..."`. This command deploys the provided shapes with the currently selected network using a x86_64 binary of odo.

### Setting up DNS for your network
Next, setup DNS records for your seer, generated domain, and service URLs, all with a 1-minute TTL.

### Seer
For each host running seer, add an `A Record`.   
Host: seer -> Value: 127.0.0.1     

### Generated URL
Point your generated domain to your seers by adding a `NS Record`.   
If `g.example.com` is your generated domain URL, the record would be:    
Host: `g` -> Value: `seer.example.com`

### Service URL
Add a `NS Record` which by default should be your URL prefixed with tau.   
This record will also point to your seers.   
For `example.com` the record will be: `tau` -> `seer.example.com`

### Connecting to the network
It may take a few minutes for the DNS to recognize your changes. The best way to check is to perform a dig on your network's seer URL. 

Finally, connect to your network from the web-console:

1. Go to [Web Console](https://console.taubyte.com) 
2. Fill in your email and select 'Custom' in the network selector
3. Enter the network-URL and hit the checkmark
4. Login

### Adding plugins
In order to add a plugin your shape must contain the protocol `node`.   
Will also need a plugin ready to go.

1. Run `spore-drive import plugin -v "version to store under" -p "path to plugin"`
2. Create a new shape or edit an existing one and add `node`.
3. At the end it will prompt you to select plugins, select your plugin.   
   List will contain plugins with all their versions as a selection so make sure you only select one for each plugin.
4. Push your network.