# AWS_Tutorials
## Tutorial to install R Server and Shiny Server on AWS

[Inspired from this great article  great article](https://aws.amazon.com/blogs/big-data/running-r-on-aws/)

The file *Script_User_Data.txt* contains the script needed to install **at launch** the following
* R
* RServer
* Shiny
* Shiny Server

## Launching the instance
When launching an instance, use the *User Data* in *Script_User_Data.txt*.

Be careful to configure the **Security Group**. Hint, RServer uses the port **8787** and Shiny Server the port **3838**.

## User Data Output
To see what has happened **at launch**, you can check the user data output in the following file:
* **/var/log/cloud-init-output.log**

## Configuring the Shiny Server
Once the Server Shiny is set up, a little configuration is needed.
Connect to the instance and launch the following command lines:

```
mkdir ~/ShinyApps
sudo /opt/shiny-server/bin/deploy-example user-dirs
cp -R /opt/shiny-server/samples/sample-apps/hello ~/ShinyApps/
```

Finally you can check that it works using the following:

__http://*YOU_IP*:3838/ec2-user/hello/__