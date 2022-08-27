# Reader-app with Cloudron
- https://github.com/hectorqin/reader
- https://www.cloudron.io/

## Usage

1. Install cloudron cli `npm install -g cloudron`
2. Login to your cloudron instance `cloudron login my.example.com`
3. Install this app `cloudron install --image tobosdf/reader:latest`
4. Wait until the health check finish
5. Please edit your `env` file via cloudron's file manager and change the following env vars:
- `READER_APP_SECUREKEY`
- `READER_APP_INVITECODE`
6. Restart `cloudron restart --app reader.example.com`
7. Enjoy!
