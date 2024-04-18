# infra

This contains reverse proxy configuration.

## Initial setup

This is always made slightly tricky by the fact that nginx requires the ssl certificates to be present in order to start up. This poses a chicken-and-egg problem, in that we require nginx to be serving the letsencrypt ACME challenge in order to retrieve the certificates in order to start nginx. We solve this simply by running the https server separately.

First, create the nginx configurations:

```bash
mkdir -p /etc/nginx
cp nginx-ingress-http.conf /etc/nginx/nginx-ingress-http.conf
cp nginx-ingress-https.conf /etc/nginx/nginx-ingress-https.conf
```

```bash
# create the http server
cp nginx-ingress-http.service /etc/systemd/system/nginx-ingress-http.service
systemctl enable nginx-ingress-http.service
systemctl start nginx-ingress-http.service
journalctl -u nginx-ingress-http.service
```

Now we're listening for ACME challenges, we can run certbot to generate the certificate.

```bash
cp letsencrypt-generate-cert@.service /etc/systemd/system/letsencrypt-generate-cert@.service
systemctl start letsencrypt-generate-cert@homeassistant.jusi.house.service
systemctl start letsencrypt-generate-cert@files.horlick.me.service
journalctl -u letsencrypt-generate-cert@homeassistant.jusi.house.service
journalctl -u letsencrypt-generate-cert@files.horlick.me.service
```

Create a timer that will auto-renew the certificate before it expires.

```bash
cp letsencrypt-renew-cert.service letsencrypt-renew-cert.timer /etc/systemd/system/
systemctl enable letsencrypt-renew-cert.timer
systemctl start letsencrypt-renew-cert.timer
systemctl list-timers --all
```

Finally we can install and start the https server.

```bash
# create the Diffie–Hellman parameters
openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048

# create the https server
cp nginx-ingress-https.service /etc/systemd/system/nginx-ingress-https.service
systemctl enable nginx-ingress-https.service
systemctl start nginx-ingress-https.service
journalctl -f -u nginx-ingress-https.service
```
