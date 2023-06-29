# Part 1: Web Console
 ## Login
  Follow instruction in https://tau.how/docs/getting-started/login
 ## Create a project
  Follow instruction in https://tau.how/docs/getting-started/project
 ## Create a Function
  Follow instruction in https://tau.how/docs/getting-started/first-serverless-function
 ## Create a Website (Challenge)
  Should be quite easy (if you followed my example)

# Part 2: Create a project using tau
 ## Install
   ### Using go install 
   https://tau.how/docs/tau/go_install
   ### from source
   https://tau.how/docs/tau/source/manual

 ## Shell Completion (Optional)
 https://tau.how/docs/tau/autocomplete


 ## Login
 https://tau.how/docs/tau/login

 ## Create a project
 https://tau.how/docs/tau/project/new


 ## Create a function
 https://tau.how/docs/tau/function/new

# Part 3: Use dreamland to test changes
For this part you will use use Github codespace

### Login with tau
Follow the same teps as before. Except for the github token, select manual and input the token. you can get from `~/tau.yaml`


# Part 4: Deploy your own network
For deployment you're going to use `spore-drive` and deploy a one-node network on an equinix I will provide you.

For this tutorial we are going to be using `example.com` as the network url

## Create A Network
1. Run `spore-drive new network`   
2. Provide network name
3. Provide network URL  
4. Select swarm key option (Select Generate for the the walkthrough)
5. Provide generated domain (best if its a subdomain of your network url, ex: `g.example.com`)
6. Select domain validation key Option (Select Generate for the the walkthrough)
7. Provide any validation url/regex skips   
Any urls/regex given will skip any checks/validation and will serve them normally

After creating a network running `spore-drive current` will show your network as selected

## Create A Key For SSH
1. Run `spore-drive new key`
2. Provide name
3. Provide the username for ssh
4. Provide ssh key (Drag and drop the file or provide local path. Cannot process ~ though.)   
Make sure to remove any extra spaces at the end if any


## Create a shape
It's good to have a shape that has no protocols , we call it an elder, as a main bootstrapper to help all nodes connect to each other.
1. Run `spore-drive new shape`
2. Provide name
3. Select Protocols
4. Provide the ports to run nodes on (main,lite,ipfs)   
If no protocols it is considered an “elder” and will only ask for main port  
If protocols but no node will ask for main, and lite port  
If it has node it will ask for main, lite and ipfs port



## Create a host
1. Run `spore-drive new host`
2. Provide name
3. Provide IP of the vm/server
4. Select if same as public address   
False -> Must provide public address   
True -> Becomes same as IP address
7. Provide any additional address IP/CIDR (any private ip's)
8. Provide SSH Port (Defaults to 22 if empty)
9. Select the key that corresponds to the vm to ssh
10. Provide Lat,Long (optional)
11. Select shapes to deploy on host
12. Select Shapes to add to network bootstrap  
  All nodes will connect to these nodes in the bootstrap


## Setting up monkey to build
Monkey will require docker in order to properly build jobs
Download docker.  
Refer: [Ubuntu Install Docker](https://docs.docker.com/engine/install/ubuntu/)

## Setting up DNS for seer
We will need to free up DNS so that seer can start properly. 
1. open `/etc/systemd/resolved.conf` with any  text editor (nano, vim)
2. Set  
  a. DNS=1.1.1.1   
  b. DNSStubListener=no
3. Run `systemctl restart systemd-resolved.service`
5. Run `ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf`

## Deploy your network
After setting up everything above it is time to deploy the network
1. To easily deploy run `spore-drive deploy -s shape1,shape2..."`   
This will deploy the shapes provided with the currently selected network using a x86_64 binary of odo


## Setting up DNS for your network
You will need to setup dns records for your seer,generated domain, and service urls.   
For all these records best to have a 1 minute TTL

### Seer
Add an `A Record` for each host that is running seer.   
Host: seer -> Value: 127.0.0.1     

### Generated URL
Add a `NS Record` that points your generated domain to your seers    
I have `g.example.com`as my generated domain url so the record would be:    
Host: `g` -> Value: `seer.example.com`

### Service URL
Add a `NS Record` which is defaulted to be your url prefixed with tau.   
This record will also point to your seers   
So the record for `example.com` will be `tau` -> `seer.example.com`

## Connecting to the network
It might take a minute or so for the dns to recognize your changes.   
Best way to check is to do a dig on your network's seer url to see if it has updated.   
Last step is to connect to your network from web-console

1. Go to [web-console](https://console.taubyte.com/login) 
2. Fill in email and select Custom in network selector
3. Enter in the network-url and hit the checkmark
4. Login