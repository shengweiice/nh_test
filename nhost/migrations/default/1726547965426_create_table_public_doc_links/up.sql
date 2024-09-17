CREATE TABLE "public"."doc_links" ("id" uuid NOT NULL DEFAULT gen_random_uuid(), "created_at" timestamptz NOT NULL DEFAULT now(), "updated_at" timestamptz NOT NULL DEFAULT now(), "doc_id" uuid NOT NULL, "is_active" boolean NOT NULL DEFAULT true, "require_email_to_view" boolean NOT NULL DEFAULT false, "passcode" text, "allow_download" boolean NOT NULL DEFAULT false, PRIMARY KEY ("id") , FOREIGN KEY ("doc_id") REFERENCES "public"."docs"("id") ON UPDATE restrict ON DELETE cascade);
CREATE OR REPLACE FUNCTION "public"."set_current_timestamp_updated_at"()
RETURNS TRIGGER AS $$
DECLARE
  _new record;
BEGIN
  _new := NEW;
  _new."updated_at" = NOW();
  RETURN _new;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER "set_public_doc_links_updated_at"
BEFORE UPDATE ON "public"."doc_links"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_doc_links_updated_at" ON "public"."doc_links"
IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE EXTENSION IF NOT EXISTS pgcrypto;
