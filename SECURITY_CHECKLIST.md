# eOpenCA Security Verification Checklist

## Token Security
- [ ] No OAuth access/refresh tokens on the Flutter client
- [ ] Sentin8:BFF holds all tokens server-side (encrypted in Valkey)
- [ ] Session token is opaque (no embedded claims)

## Inter-Service Token Verification
- [ ] All Sentin8:BFF → Bank8:FDX calls include Sentin8:Auth-issued access token
- [ ] All Sentin8:BFF → Sentin8:DB calls include Sentin8:Auth-issued access token
- [ ] All Sentin8:BFF → Sentin8:Storage calls include Sentin8:Auth-issued access token
- [ ] No unauthenticated requests accepted

## Sentin8:DB Table Compliance
- [ ] EOpenCACustomerProfile includes org_id, env_id, id, created_at, updated_at, resource_version
- [ ] EOpenCAProviderConnection includes all mandatory system columns
- [ ] EOpenCAAccountView includes all mandatory system columns
- [ ] EOpenCATransactionView includes all mandatory system columns
- [ ] EOpenCARefreshJob includes all mandatory system columns

## RLS Context
- [ ] RLS context set before every Sentin8:DB query (6 session variables)
- [ ] Production roles cannot disable RLS
- [ ] Missing RLS context fails closed

## Sentin8:Storage Compliance
- [ ] All object references use Sentin8:StorageObjectReference pattern
- [ ] No raw storage credentials in Sentin8:DB rows

## No Direct Substrate Access
- [ ] No native PostgreSQL driver imports
- [ ] No raw SQL queries
- [ ] No ORM bypass
- [ ] No direct storage SDK usage

## Secret References
- [ ] No plaintext secrets in source code or config
- [ ] OAuth client secrets stored as secret references

## No Direct External Provider Calls
- [ ] eOpenCA never calls external FDX providers directly
- [ ] All external provider communication through Bank8:FDX recipient orchestration

## No Raw External Tokens
- [ ] eOpenCA never receives raw external provider tokens
- [ ] Sentin8:Auth stores token material as secret references
- [ ] Bank8:FDX stores grant references (not raw tokens)

## CI Guards (4.3.10-4.3.12)
- [ ] CI detects outbound HTTP calls to non-Sentin8 hosts
- [ ] CI detects native PostgreSQL drivers, raw SQL, ORM bypass, direct storage SDK usage
- [ ] CI detects token-like strings in eOpenCA code and config