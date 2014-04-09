basic-redis cookbook
====================

This Chef cookbook installs redis.

This basic-redis cookbook has very limited configurability and likely you'll want to use
the official redis cookbook for your deployments instead.

Personally I find the community cookbooks too complicated; this cookbook is tailored to my personal
needs.

# Running

You need Kitchen CI (http://kitchen.ci/) to run a test VM.

Enter the following command to create a running instance:

    kitchen converge default-centos-65

To open a command line SSH connection, run the following:

    kitchen login default-centos-65

To test whether the install is working property execute:

    kitchen verify default-centos-65

# Dependencies / contributions

Based on https://github.com/miah/chef-redis

# License

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
