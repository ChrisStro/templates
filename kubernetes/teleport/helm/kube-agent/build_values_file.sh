#!/bin/bash
CHART_NAME="teleport-kube-agent"
REPO_NAME="teleport"
REPO_URL="https://charts.releases.teleport.dev"

# scriptvars
SCRIPT_PATH=${BASH_SOURCE[0]}
SCRIPT_FOLDER=$(dirname -- $SCRIPT_PATH)
VALUETEMPLATE="values.tpl.yml"
VALUEFILE="values.yml"

# add repo
helm repo add $REPO_NAME $REPO_URL
helm repo update $REPO_NAME
echo ""

# create values template file
test -f "$SCRIPT_FOLDER/$VALUETEMPLATE" && echo -e "$VALUETEMPLATE already exists\n" || {
    # using helm
    helm show values $REPO_NAME/$CHART_NAME | tee $SCRIPT_FOLDER/$VALUETEMPLATE 1> /dev/null
    echo ""
}

# create values file
test -f "$SCRIPT_FOLDER/$VALUEFILE" && echo -e "$VALUEFILE already exists\n" || {
    [[ -z "$MYDOMAINNAME" ]] && {
        read -p "Enter your DomainName: " MYDOMAINNAME
    }
    [[ -z "$MYCLUSTERNAME" ]] && {
        read -p "Enter your ClusterName: " MYCLUSTERNAME
    }
    [[ -z "$MYAUTHTOKEN" ]] && {
        read -p "Enter your AuthToken: " MYAUTHTOKEN
    }
    echo "Create value file with $MYDOMAINNAME as cluster-name"
    sed "s/<DOMAINNAME>/$MYDOMAINNAME/g;s/<CLUSTERNAME>/$MYCLUSTERNAME/g;s/<AUTHTOKEN>/$MYAUTHTOKEN/g" $SCRIPT_FOLDER/$VALUETEMPLATE | tee $SCRIPT_FOLDER/$VALUEFILE 1> /dev/null
}