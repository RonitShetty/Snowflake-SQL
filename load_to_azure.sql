create or replace storage integration azure_int
type = external_stage
storage_provider = azure
enabled = true
azure_tenant_id = 'e339bd4b-2e3b-4035-a452-2112d502f2ff'
storage_allowed_locations =('azure://ronitshettystorage.blob.core.windows.net/container1');

desc integration azure_int;

