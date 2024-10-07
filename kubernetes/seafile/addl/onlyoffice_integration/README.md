# Enable ONLYOFFICE online view/edit
## Apply manifest files ( ingress only if needed )
```sh
kubectl apply -f onlyoffice_integration/deployment.yml
```
## Enter seafile container
```sh
kubectl exec -it deploy/seafile-app -c seafile -- bash
```
## Edit seahub_settings.py
```sh
vi /shared/seafile/conf/seahub_settings.py
```

```python
ONLYOFFICE_JWT_SECRET = 'same_as_ONLYOFFICE_JWT_SECRET_in_seafile-app-cm'

# Enable OnlyOffice
ENABLE_ONLYOFFICE = True
VERIFY_ONLYOFFICE_CERTIFICATE = False
ONLYOFFICE_APIJS_URL = 'https://onlyofficeds.local.127.0.0.1.sslip.io/web-apps/apps/api/documents/api.js' # Must be resolvebale by seafile-mc container
ONLYOFFICE_FILE_EXTENSION = ('doc', 'docx', 'ppt', 'pptx', 'xls', 'xlsx', 'odt', 'fodt', 'odp', 'fodp', 'ods', 'fods')
ONLYOFFICE_EDIT_FILE_EXTENSION = ('docx', 'pptx', 'xlsx')

# User can save file when press save button on OnlyOffice file edit page
ONLYOFFICE_FORCE_SAVE = True
```

## Restart services in seafile container ( or restart deployment )
```sh
/opt/seafile/seafile-server-9.0.10/seafile.sh restart
/opt/seafile/seafile-server-9.0.10/seahub.sh restart

```

*Note: I will create job resource in the future to automate this process*