#!/bin/bash
CHART_NAME="teleport-cluster"
REPO_NAME="teleport"
REPO_URL="https://charts.releases.teleport.dev"

# scriptvars
SCRIPT_PATH=${BASH_SOURCE[0]}
SCRIPT_FOLDER=$(dirname -- $SCRIPT_PATH)
CERTTEMPLATE="teleport_san_cert.yml"
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
    echo "Create value file with $MYDOMAINNAME as cluster-name"
    sed "s/<DOMAINNAME>/$MYDOMAINNAME/g;s/<CLUSTERISSUER>/$MYCLUSERISSUER/g" $SCRIPT_FOLDER/$VALUETEMPLATE | tee $SCRIPT_FOLDER/$VALUEFILE 1> /dev/null
}

# create own ingress manifest
test -f "$SCRIPT_FOLDER/ingress.yml" && echo -e "ingress.yml already exists\n" || {
    [[ -z "$MYCLUSERISSUER" ]] && {
        CLUSERISSUERLIST=$(kubectl get clusterissuer | awk 'NR>1 {print $1}')
        PS3="Select Clusterissuer for ingress: "
        select MYCLUSERISSUER in $CLUSERISSUERLIST
            do echo "$MYCLUSERISSUER selected"; break
        done
        [[ $CLUSERISSUERLIST =~ $MYCLUSERISSUER ]] && [[ $MYCLUSERISSUER != "" ]] || {
            echo "Wrong selection, abort script.."
            exit 1;
        }
        echo "Configure $MYCLUSERISSUER for cert-manager annotation"
    }
    echo "Create own ingress manifest to support auto-cert with cert-manager"
    sed "s/<DOMAINNAME>/$MYDOMAINNAME/g;s/<CLUSTERISSUER>/$MYCLUSERISSUER/g" $SCRIPT_FOLDER/ingress.tpl.yml | tee $SCRIPT_FOLDER/ingress.yml 1> /dev/null
}