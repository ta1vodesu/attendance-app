-- daily_reports のRLS方針:
--   member: 自分の日報を閲覧/追加/編集/削除できる
--   admin : 全員の日報を「閲覧」だけできる（追加/編集/削除は不可＝他人の行に書き込めない）
-- SELECT は本人＋admin のまま。INSERT/UPDATE/DELETE から admin 権限を外し「本人のみ」に変更する。
-- カラム名はCLAUDE.md設計のまま（変更なし）。

-- SELECT: 本人＋admin（据え置き。念のため再定義）
drop policy if exists "daily_reports_select_own_or_admin" on public.daily_reports;
create policy "daily_reports_select_own_or_admin"
on public.daily_reports for select
to authenticated
using (user_id = auth.uid() or public.is_admin());

-- INSERT: 本人のみ
drop policy if exists "daily_reports_insert_own_or_admin" on public.daily_reports;
drop policy if exists "daily_reports_insert_own" on public.daily_reports;
create policy "daily_reports_insert_own"
on public.daily_reports for insert
to authenticated
with check (user_id = auth.uid());

-- UPDATE: 本人のみ
drop policy if exists "daily_reports_update_own_or_admin" on public.daily_reports;
drop policy if exists "daily_reports_update_own" on public.daily_reports;
create policy "daily_reports_update_own"
on public.daily_reports for update
to authenticated
using (user_id = auth.uid())
with check (user_id = auth.uid());

-- DELETE: 本人のみ
drop policy if exists "daily_reports_delete_own_or_admin" on public.daily_reports;
drop policy if exists "daily_reports_delete_own" on public.daily_reports;
create policy "daily_reports_delete_own"
on public.daily_reports for delete
to authenticated
using (user_id = auth.uid());
