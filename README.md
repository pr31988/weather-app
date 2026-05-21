## Phase 1
- Configure Azure OIDC [ Microsoft Entra ID > App registrations > New registration], Add credential [Certificates & secrets > Federated credentials]
- Assign Permissions [az role assignment create --assignee <SP_OBJECT_ID> --role "User Access Administrator" --scope /subscriptions/<SUBSCRIPTION_ID>]
- Run git Action workflow:
  <img width="800" height="800" alt="weather-API" src="https://github.com/user-attachments/assets/4649dd0e-5809-4dfc-a7a2-aa91f68501c7" />
- configure web app environment variables 
