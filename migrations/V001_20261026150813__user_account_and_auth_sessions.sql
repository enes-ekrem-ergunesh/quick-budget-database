-- user_account_and_auth_sessions

create table user_account
(
    id            integer generated always as identity
        constraint user_account_pk
            primary key,
    email         varchar(320) not null
        constraint user_account_email_uq
            unique,
    password_hash text,
    created_at    timestamp    not null,
    updated_at    timestamp
);

alter table user_account
    owner to qbudget;

create index user_account_email_index
    on user_account (email);

create table auth_session
(
    id                     uuid      not null
        constraint auth_session_pk
            primary key,
    user_id                integer   not null
        constraint auth_session_user_account_id_fk
            references user_account,
    refresh_token_hash     text      not null,
    expires_at             timestamp,
    revoked_at             timestamp,
    replaced_by_session_id uuid
        constraint auth_session_auth_session_id_fk
            references auth_session,
    created_at             timestamp not null
);

alter table auth_session
    owner to qbudget;