alter table "public"."doc_links" drop constraint "doc_links_doc_id_fkey",
  add constraint "doc_links_doc_id_fkey"
  foreign key ("doc_id")
  references "public"."docs"
  ("id") on update restrict on delete cascade;
