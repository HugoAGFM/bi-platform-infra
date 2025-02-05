# How to develop github actions workflow locally using act
`act -P ubuntu-latest=catthehacker/ubuntu:act-latest --secret-file .env -e push-event.json  --artifact-server-path ./act-artifacts`

- `.env` file should contain variables to authenticate in azure (`AZURE_CLIENT_ID`, `AZURE_CLIENT_SECRET`, `AZURE_TENANT_ID`, `AZURE_SUBSCRIPTION_ID`).
- `push-event.json` should have the data of a github push event, like the example below.

```
{
    "ref": "refs/heads/development",
    "before": "0000000000000000000000000000000000000000",
    "after": "0000000000000000000000000000000000000000",
    "repository": {
      "default_branch": "main"
    }
}
```

