# To create a new key for a site

## Steps:
1. `mkdir ~/.ssh/_your_sitename_`
2. `ssh-keygen -t ed25519 -C _your_email_ -f ~/.ssh/_your_sitename_/somecustomname_ed25519`
    - `-t`: type of key; just use ed25519 (or rsa for legacy systems that don't support ed25519)
    - `-f`: outputs a keyfile
    - `-C`: comment
    - what to name `somecustomname`? go with `site-purpose-algorithm`
        - e.g. `github-auth-ed25519` for authentication in github
        - e.g. `github-signing-ed25519` for signing in github

## Syntax for OpenSSH's config file located in ~/.ssh/config
- `Host _some_sitename_`: This section defines the settings for a specific host or group of hosts. Wildcards can be used.
e.g. `*.example.com`
- `HostName _some_sitename_or_ip_address_`: The actual hostname or IP address of the remote server.
- `User: _username_` This is not your non-SSH login username; it's your SSH username to logon to the remote server. It's
  defined by the server. Github and Gitlab use `git`. When unclear, google/chatgpt/check other config files on github.
- `Port _some_port_number_`: The port number to connect to on the remote server (default is 22).
- `ProxyJump _some_proxy_server_`: Specifies a proxy server to use for connecting to the remote server.
- `ForwardAgent yes`: Enables SSH agent forwarding. Not encouraged; security nightmare.
- `AddKeysToAgent yes`: Adds the specified identity file to ssh-agent.
- `IdentityFile _your_keyfile_dir_`: The path to the private key file for authentication.
- `IdentitiesOnly yes`: Ensures that only the specified identity files are used for authentication.

## Order of priority for multiple keys under same HostName
e.g.
```
Host github.com
  HostName github.com
  User git
  IdentitiesOnly yes
  AddKeysToAgent yes
  IdentityFile ~/.ssh/github.com/keyname_1
  IdentityFile ~/.ssh/github.com/keyname_2
  IdentityFile ~/.ssh/github.com/keyname_3
```
- `keyname_1` is first, then `keyname_2`, then `keyname_3`

## Test your SSH passphrase (do this in private)
- `ssh-keygen -y -f ~/.ssh/_your_keyfile_dir_`: prompts for your passphrase. If correct, it will print your private key.
