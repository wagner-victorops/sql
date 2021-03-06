# Perform Common SQL Queries Directly from the Terminal

Requires MySQL client for the terminal.  If you have HomeBrew, install with `brew install mysql`

Clone this repo locally so you can take advantage of any updates.

Add the following lines to your bash profile.  You may need to change the directory to match the directory where you cloned this repo.  (In the below example, the repo is `~/GitHub/sql`)


```bash
# Execute SQL script with argument
        function find_user() {
                ./GitHub/sql/find_user.sh $1
                }

        function find_org() {
                ./GitHub/sql/find_org.sh $1
                }

        function get_admins() {
                ./GitHub/sql/get_admins.sh $@
                }

        function incident() {
                ./GitHub/sql/incident_audit.sh $1 $2
                }
        function poll_org() {
                ./GitHub/sql/poll_org.sh $1
                }

        function splunk_users() {
                ./GitHub/sql/get_splunk_users.sh
                }

        function splunk_orgs() {
                ./GitHub/sql/get_splunk_orgs.sh
                }

        function autopause() {
                ./GitHub/sql/auto_paused_orgs.sh
                }

        function overrides() {
                ./GitHub/sql/show_overrides.sh $1
                }

        function splunk_orgs_enabled() {
                ./GitHub/sql/get_enabled_splunk_orgs.sh
                }

        function phone() {
                ./GitHub/sql/country_code.sh $1
                }

        function find_domain() {
                ./GitHub/sql/find_domain.sh $1
                }

        function essentials() {
                ./GitHub/sql/essentials_org_slugs.sh
                }

        function full_stack() {
                ./GitHub/sql/full_stack_org_slugs.sh
                }

        function free_orgs() {
                ./GitHub/sql/free_org_slugs.sh
                }

        function trials_since() {
                ./GitHub/sql/trials_since_date.sh $1
                }

        function find_team() {
                ./GitHub/sql/find_team_slug.sh $1
                }

        function find_escalation_policy() {
                ./GitHub/sql/find_escalation_policy_slug.sh $1
                }

```

### find_user
Takes a single argument that can be either a username or an email address.  For example `find_user jdevops` and `find_user johnny.devops@company.com` will both work.  It should return all relevant info about the user.

### find_org
Takes a single argument that must be the org slug, like `find_org ops-testing`.  It will return all relevant information about the org.

### get_admins
Takes a single argument that must be the org slug, like `get_admins ops-testing`.  It will list out all of the email addresses for all administrators in that org in a format that can be copied from the terminal and pasted into a SF case email.  Be sure to comb throught he list of emails to eliminate duplicates, as this will give all the email addresses listed for each admin user (No need to hit ALL of them, just opt for the one that seems like their work email account)

### incident
Takes two positional arguments: the incident number and the org slug, like so: `incident 1234 ops-testing`.  This will return all the events related to the incident in chronological order (This is the "Incident Audit Query")

### splunk_users
No arguments, just executed as `splunk_users`.  This will return a de-duped list of all users with a splunk.com email address, while filtering out any known internal VictorOps orgs.  Simply add an additional `and o.slug not like \"whatever\"` statement to eliminate any that creep in.

### splunk_orgs
No arguments, just passed as `splunk_orgs`.  This will return relevant info (including current user count) for all Splunk orgs, with internal VictorOps orgs filtered out. Simply add an additional `and o.slug not like \"whatever\"` statement to eliminate any that creep in.

### splunk_orgs_enabled
No arguments, just passed as `splunk_orgs_enabled`.  Same as above but it only shows currently enabled orgs. Simply add an additional `and o.slug not like \"whatever\"` statement to eliminate any that creep in.

### autopause
No arguments, just passed as `autopause`.  This will return a list of any orgs who are currently auto-paused on ALertCore4.

### overrides
Takes 1 argument: the org slug.  Returns all active overrides in place for that org (both manual and scheduled) with all the relevant details.

### phone
Takes one argument: All or part (country code) of a phone number For example, pass `country_code +48` for all users with a Polish phone number or pass `phone 555-555-5555` to find the user with that number.  Returns a list of all users with phone numbers using that country code.  (How many users do we have with Polish phone numbers?)

### find_domain
Takes 1 argument: an email domain (like 'splunk.com').  This will return all orgs in which a member of that org has an email address with that domain.

### essentials
No arguments.  Returns a sequence of org slugs with the "essentials" package, sandwiched by double quotes and separated by commas.

### full_stack
No arguments.  Returns a sequence of org slugs with the "full stack" package, sandwiched by double quotes and separated by commas.

### free_orgs
No arguments.  Returns a sequence of org slugs with the "free" package, sandwiched by double quotes and separated by commas.

### trials_since
Takes 1 argument: date / time.  Returns a sequence of org slugs for all new trials created after the provided date/time, sandwiched by double quotes and separated by commas.  The date/time format of the argument must conform to the format used in the vo_hier.Organizations.created_on column.  YYYY-MM-DD HH:MM:SS)

### find_team
Takes 1 argument: team slug.  Returns org name, org slug, team name, team slug.

### find_escalation_policy
Takes 1 argument: escalation policy slug.  Returns org name, org slug, escalation policy name, escalation policy slug.