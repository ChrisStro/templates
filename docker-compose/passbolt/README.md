# Passbolt CE

Passbolt is a free and open source password manager that allows team members to store and share credentials securely. The Community Edition lags behind in a few key features like totp token sharing, but overall it's a nice, modern-looking password manager.

[GitHub Page](https://github.com/passbolt)

## Notes
- Run following command inside container to create first user
```
docker compose exec passbolt /usr/share/php/passbolt/bin/cake passbolt register_user -u <USERNAME_EMAIL> -f <FIRSTNAME> -l <LASTNAME> -r admin
```
- Create reset link for user
```
docker compose exec passbolt /usr/share/php/passbolt/bin/cake passbolt recover_user -u <USERNAME_EMAIL>
```