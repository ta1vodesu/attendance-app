-- 保留時などに管理者から申請者へ伝えるコメント
alter table public.shifts
  add column if not exists review_comment text;

comment on column public.shifts.review_comment is '管理者から申請者へのコメント（保留理由など）';
