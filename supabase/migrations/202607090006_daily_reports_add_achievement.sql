-- 日報に「自己達成度」列を追加（0〜100%、任意）。カラム名はCLAUDE.md設計に沿った命名。
alter table public.daily_reports
  add column if not exists achievement smallint
    check (achievement is null or (achievement >= 0 and achievement <= 100));

comment on column public.daily_reports.achievement is '自己達成度（0〜100%）';
