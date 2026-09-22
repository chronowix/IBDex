-- 1. Création de la table users dans le schéma public
create table public.users (
  id uuid references auth.users not null primary key,
  full_name text,
  email text,
  region text default 'Rennes',
  mici_type text, -- 'Crohn', 'RCH', 'Autre'
  updated_at timestamp with time zone,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- 2. Activer la sécurité au niveau des lignes (RLS)
alter table public.users enable row level security;

-- 3. Définir les politiques de sécurité (Policies)
create policy "Les utilisateurs voient leur propre profil." 
on public.users for select 
using (auth.uid() = id);

create policy "Les utilisateurs modifient leur propre profil." 
on public.users for update 
using (auth.uid() = id);

-- 4. Fonction pour créer automatiquement un profil public à l'inscription
create function public.handle_new_user()
returns trigger as $$
begin
  insert into public.users (id, full_name, email)
  values (new.id, new.raw_user_meta_data->>'full_name', new.email);
  return new;
end;
$$ language plpgsql security definer;

-- 5. Trigger qui déclenche la fonction après chaque inscription dans auth.users
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();
