-- remove_session_refresh
-- Drop the columns related to refreshing sessions

alter table auth_session
    drop column refresh_token_hash;

alter table auth_session
    drop constraint auth_session_auth_session_id_fk;

alter table auth_session
    drop column replaced_by_session_id;