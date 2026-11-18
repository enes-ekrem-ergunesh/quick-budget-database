-- entry_and_category
-- Add Entries, categories, cefault categories and entry types. update the existing timestamp fields with timestamptz

create type entry_type as enum ('income', 'expense');

alter type entry_type owner to qbudget;

alter table user_account
    alter column created_at type timestamp with time zone using created_at::timestamp with time zone;

alter table user_account
    alter column updated_at type timestamp with time zone using updated_at::timestamp with time zone;

alter table auth_session
    alter column expires_at type timestamp with time zone using expires_at::timestamp with time zone;

alter table auth_session
    alter column revoked_at type timestamp with time zone using revoked_at::timestamp with time zone;

alter table auth_session
    alter column created_at type timestamp with time zone using created_at::timestamp with time zone;

create table category
(
    id         uuid                                               not null
        constraint category_pk
            primary key,
    title      varchar(50)                                        not null,
    emoji      varchar(10)                                        not null,
    created_at timestamp with time zone default CURRENT_TIMESTAMP not null,
    updated_at timestamp with time zone,
    user_id    uuid                                               not null
        constraint category_user_account_id_fk
            references user_account,
    constraint category_title_user_id_uq
        unique (title, user_id)
);

alter table category
    owner to qbudget;

create table entry
(
    id          uuid                                               not null
        constraint entry_pk
            primary key,
    user_id     uuid                                               not null
        constraint entry_user_account_id_fk
            references user_account,
    category_id uuid
        constraint entry_category_id_fk
            references category
            on delete set null,
    title       varchar(250)                                       not null,
    amount      double precision,
    currency    varchar(3),
    type        entry_type,
    entry_date  date,
    entry_time  time,
    note        text,
    created_at  timestamp with time zone default CURRENT_TIMESTAMP not null,
    updated_at  timestamp with time zone
);

alter table entry
    owner to qbudget;

create table default_category
(
    id         integer generated always as identity
        constraint default_categories_pk
            primary key,
    title      varchar(50)                                        not null
        constraint default_category_title_uq
            unique,
    emoji      varchar(10)                                         not null,
    created_at timestamp with time zone default CURRENT_TIMESTAMP not null,
    updated_at timestamp with time zone
);

alter table default_category
    owner to qbudget;

