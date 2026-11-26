-- Esquema opcional para la sincronización de IraChess en Supabase (plan gratuito).
-- Ejecutar en el editor SQL del proyecto. Cada usuario solo ve sus filas (RLS).

create or replace function set_server_at() returns trigger language plpgsql as $$
begin new.server_at = now(); return new; end $$;

create table if not exists games (
  user_id uuid not null default auth.uid() references auth.users on delete cascade,
  source text not null,
  external_id text not null,
  pgn text not null check (length(pgn) < 2000000),
  user_side text check (user_side in ('white', 'black')),
  deleted boolean not null default false,
  updated_at timestamptz not null,
  server_at timestamptz not null default now(),
  primary key (user_id, source, external_id)
);
create trigger games_server_at before update on games for each row execute function set_server_at();

create table if not exists puzzle_attempts (
  id uuid primary key,
  user_id uuid not null default auth.uid() references auth.users on delete cascade,
  puzzle_id text not null,
  solved boolean not null,
  hints_used int not null default 0,
  time_ms int not null,
  puzzle_rating int not null,
  attempted_at timestamptz not null,
  server_at timestamptz not null default now()
);

create table if not exists vision_sessions (
  id uuid primary key,
  user_id uuid not null default auth.uid() references auth.users on delete cascade,
  mode text not null,
  side text not null,
  coords boolean not null,
  score int not null,
  errors int not null,
  duration_ms int not null,
  misses jsonb not null default '[]',
  started_at timestamptz not null,
  server_at timestamptz not null default now()
);

alter table games enable row level security;
alter table puzzle_attempts enable row level security;
alter table vision_sessions enable row level security;
create policy own_games on games for all using (user_id = auth.uid()) with check (user_id = auth.uid());
create policy own_attempts on puzzle_attempts for all using (user_id = auth.uid()) with check (user_id = auth.uid());
create policy own_vision on vision_sessions for all using (user_id = auth.uid()) with check (user_id = auth.uid());
