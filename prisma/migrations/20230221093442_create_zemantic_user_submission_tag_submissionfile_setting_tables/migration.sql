-- CreateTable
CREATE TABLE "activity" (
    "id" TEXT NOT NULL,
    "timestamp" TIMESTAMP(6),
    "user_id" TEXT,
    "object_id" TEXT,
    "revision_id" TEXT,
    "activity_type" TEXT,
    "data" TEXT,

    CONSTRAINT "activity_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "activity_detail" (
    "id" TEXT NOT NULL,
    "activity_id" TEXT,
    "object_id" TEXT,
    "object_type" TEXT,
    "activity_type" TEXT,
    "data" TEXT,

    CONSTRAINT "activity_detail_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "alembic_version" (
    "version_num" VARCHAR(32) NOT NULL,

    CONSTRAINT "alembic_version_pkc" PRIMARY KEY ("version_num")
);

-- CreateTable
CREATE TABLE "api_token" (
    "id" TEXT NOT NULL,
    "name" TEXT,
    "user_id" TEXT,
    "created_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    "last_access" TIMESTAMP(6),
    "plugin_extras" JSONB,

    CONSTRAINT "api_token_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "dashboard" (
    "user_id" TEXT NOT NULL,
    "activity_stream_last_viewed" TIMESTAMP(6) NOT NULL,
    "email_last_sent" TIMESTAMP(6) NOT NULL DEFAULT LOCALTIMESTAMP,

    CONSTRAINT "dashboard_pkey" PRIMARY KEY ("user_id")
);

-- CreateTable
CREATE TABLE "group" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "title" TEXT,
    "description" TEXT,
    "created" TIMESTAMP(6),
    "state" TEXT,
    "type" TEXT NOT NULL,
    "approval_status" TEXT,
    "image_url" TEXT,
    "is_organization" BOOLEAN DEFAULT false,

    CONSTRAINT "group_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "group_extra" (
    "id" TEXT NOT NULL,
    "group_id" TEXT,
    "key" TEXT,
    "value" TEXT,
    "state" TEXT,

    CONSTRAINT "group_extra_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "group_extra_revision" (
    "id" TEXT NOT NULL,
    "group_id" TEXT,
    "key" TEXT,
    "value" TEXT,
    "state" TEXT,
    "revision_id" TEXT NOT NULL,
    "continuity_id" TEXT,
    "expired_id" TEXT,
    "revision_timestamp" TIMESTAMP(6),
    "expired_timestamp" TIMESTAMP(6),
    "current" BOOLEAN,

    CONSTRAINT "group_extra_revision_pkey" PRIMARY KEY ("id","revision_id")
);

-- CreateTable
CREATE TABLE "group_revision" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "title" TEXT,
    "description" TEXT,
    "created" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    "state" TEXT,
    "revision_id" TEXT NOT NULL,
    "continuity_id" TEXT,
    "expired_id" TEXT,
    "revision_timestamp" TIMESTAMP(6),
    "expired_timestamp" TIMESTAMP(6),
    "current" BOOLEAN,
    "type" TEXT NOT NULL,
    "approval_status" TEXT,
    "image_url" TEXT,
    "is_organization" BOOLEAN DEFAULT false,

    CONSTRAINT "group_revision_pkey" PRIMARY KEY ("id","revision_id")
);

-- CreateTable
CREATE TABLE "member" (
    "id" TEXT NOT NULL,
    "group_id" TEXT,
    "table_id" TEXT NOT NULL,
    "state" TEXT,
    "table_name" TEXT NOT NULL,
    "capacity" TEXT NOT NULL,

    CONSTRAINT "member_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "member_revision" (
    "id" TEXT NOT NULL,
    "table_id" TEXT NOT NULL,
    "group_id" TEXT,
    "state" TEXT,
    "revision_id" TEXT NOT NULL,
    "continuity_id" TEXT,
    "expired_id" TEXT,
    "revision_timestamp" TIMESTAMP(6),
    "expired_timestamp" TIMESTAMP(6),
    "current" BOOLEAN,
    "table_name" TEXT NOT NULL,
    "capacity" TEXT NOT NULL,

    CONSTRAINT "member_revision_pkey" PRIMARY KEY ("id","revision_id")
);

-- CreateTable
CREATE TABLE "package" (
    "id" TEXT NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "title" TEXT,
    "version" VARCHAR(100),
    "url" TEXT,
    "notes" TEXT,
    "author" TEXT,
    "author_email" TEXT,
    "maintainer" TEXT,
    "maintainer_email" TEXT,
    "state" TEXT,
    "license_id" TEXT,
    "type" TEXT,
    "owner_org" TEXT,
    "private" BOOLEAN DEFAULT false,
    "metadata_modified" TIMESTAMP(6),
    "creator_user_id" TEXT,
    "metadata_created" TIMESTAMP(6),

    CONSTRAINT "package_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "package_extra" (
    "id" TEXT NOT NULL,
    "key" TEXT,
    "value" TEXT,
    "state" TEXT,
    "package_id" TEXT,

    CONSTRAINT "package_extra_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "package_extra_revision" (
    "id" TEXT NOT NULL,
    "key" TEXT,
    "value" TEXT,
    "revision_id" TEXT NOT NULL,
    "state" TEXT,
    "package_id" TEXT,
    "continuity_id" TEXT,
    "expired_id" TEXT,
    "revision_timestamp" TIMESTAMP(6),
    "expired_timestamp" TIMESTAMP(6),
    "current" BOOLEAN,

    CONSTRAINT "package_extra_revision_pkey" PRIMARY KEY ("id","revision_id")
);

-- CreateTable
CREATE TABLE "package_member" (
    "package_id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "capacity" TEXT NOT NULL,
    "modified" TIMESTAMP(6) NOT NULL,

    CONSTRAINT "package_member_pkey" PRIMARY KEY ("package_id","user_id")
);

-- CreateTable
CREATE TABLE "package_relationship" (
    "id" TEXT NOT NULL,
    "subject_package_id" TEXT,
    "object_package_id" TEXT,
    "type" TEXT,
    "comment" TEXT,
    "state" TEXT,

    CONSTRAINT "package_relationship_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "package_relationship_revision" (
    "id" TEXT NOT NULL,
    "subject_package_id" TEXT,
    "object_package_id" TEXT,
    "type" TEXT,
    "comment" TEXT,
    "revision_id" TEXT NOT NULL,
    "continuity_id" TEXT,
    "state" TEXT,
    "expired_id" TEXT,
    "revision_timestamp" TIMESTAMP(6),
    "expired_timestamp" TIMESTAMP(6),
    "current" BOOLEAN,

    CONSTRAINT "package_relationship_revision_pkey" PRIMARY KEY ("id","revision_id")
);

-- CreateTable
CREATE TABLE "package_revision" (
    "id" TEXT NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "title" TEXT,
    "version" VARCHAR(100),
    "url" TEXT,
    "notes" TEXT,
    "author" TEXT,
    "author_email" TEXT,
    "maintainer" TEXT,
    "maintainer_email" TEXT,
    "revision_id" TEXT NOT NULL,
    "state" TEXT,
    "continuity_id" TEXT,
    "license_id" TEXT,
    "expired_id" TEXT,
    "revision_timestamp" TIMESTAMP(6),
    "expired_timestamp" TIMESTAMP(6),
    "current" BOOLEAN,
    "type" TEXT,
    "owner_org" TEXT,
    "private" BOOLEAN DEFAULT false,
    "metadata_modified" TIMESTAMP(6),
    "creator_user_id" TEXT,
    "metadata_created" TIMESTAMP(6),

    CONSTRAINT "package_revision_pkey" PRIMARY KEY ("id","revision_id")
);

-- CreateTable
CREATE TABLE "package_tag" (
    "id" TEXT NOT NULL,
    "state" TEXT,
    "package_id" TEXT,
    "tag_id" TEXT,

    CONSTRAINT "package_tag_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "package_tag_revision" (
    "id" TEXT NOT NULL,
    "revision_id" TEXT NOT NULL,
    "state" TEXT,
    "package_id" TEXT,
    "tag_id" TEXT,
    "continuity_id" TEXT,
    "expired_id" TEXT,
    "revision_timestamp" TIMESTAMP(6),
    "expired_timestamp" TIMESTAMP(6),
    "current" BOOLEAN,

    CONSTRAINT "package_tag_revision_pkey" PRIMARY KEY ("id","revision_id")
);

-- CreateTable
CREATE TABLE "rating" (
    "id" TEXT NOT NULL,
    "user_id" TEXT,
    "user_ip_address" TEXT,
    "rating" DOUBLE PRECISION,
    "created" TIMESTAMP(6),
    "package_id" TEXT,

    CONSTRAINT "rating_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "resource" (
    "id" TEXT NOT NULL,
    "url" TEXT NOT NULL,
    "format" TEXT,
    "description" TEXT,
    "position" INTEGER,
    "hash" TEXT,
    "state" TEXT,
    "extras" TEXT,
    "name" TEXT,
    "resource_type" TEXT,
    "mimetype" TEXT,
    "mimetype_inner" TEXT,
    "size" BIGINT,
    "last_modified" TIMESTAMP(6),
    "cache_url" TEXT,
    "cache_last_updated" TIMESTAMP(6),
    "webstore_url" TEXT,
    "webstore_last_updated" TIMESTAMP(6),
    "created" TIMESTAMP(6),
    "url_type" TEXT,
    "package_id" TEXT NOT NULL DEFAULT '',
    "metadata_modified" TIMESTAMP(6),

    CONSTRAINT "resource_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "resource_revision" (
    "id" TEXT NOT NULL,
    "url" TEXT NOT NULL,
    "format" TEXT,
    "description" TEXT,
    "position" INTEGER,
    "revision_id" TEXT NOT NULL,
    "hash" TEXT,
    "state" TEXT,
    "continuity_id" TEXT,
    "extras" TEXT,
    "expired_id" TEXT,
    "revision_timestamp" TIMESTAMP(6),
    "expired_timestamp" TIMESTAMP(6),
    "current" BOOLEAN,
    "name" TEXT,
    "resource_type" TEXT,
    "mimetype" TEXT,
    "mimetype_inner" TEXT,
    "size" BIGINT,
    "last_modified" TIMESTAMP(6),
    "cache_url" TEXT,
    "cache_last_updated" TIMESTAMP(6),
    "webstore_url" TEXT,
    "webstore_last_updated" TIMESTAMP(6),
    "created" TIMESTAMP(6),
    "url_type" TEXT,
    "package_id" TEXT NOT NULL DEFAULT '',

    CONSTRAINT "resource_revision_pkey" PRIMARY KEY ("id","revision_id")
);

-- CreateTable
CREATE TABLE "resource_view" (
    "id" TEXT NOT NULL,
    "resource_id" TEXT,
    "title" TEXT,
    "description" TEXT,
    "view_type" TEXT NOT NULL,
    "order" INTEGER NOT NULL,
    "config" TEXT,

    CONSTRAINT "resource_view_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "revision" (
    "id" TEXT NOT NULL,
    "timestamp" TIMESTAMP(6),
    "author" VARCHAR(200),
    "message" TEXT,
    "state" TEXT,
    "approved_timestamp" TIMESTAMP(6),

    CONSTRAINT "revision_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "system_info" (
    "id" SERIAL NOT NULL,
    "key" VARCHAR(100) NOT NULL,
    "value" TEXT,
    "state" TEXT NOT NULL DEFAULT 'active',

    CONSTRAINT "system_info_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "system_info_revision" (
    "id" INTEGER NOT NULL,
    "key" VARCHAR(100) NOT NULL,
    "value" TEXT,
    "revision_id" TEXT NOT NULL,
    "continuity_id" INTEGER,
    "state" TEXT NOT NULL DEFAULT 'active',
    "expired_id" TEXT,
    "revision_timestamp" TIMESTAMP(6),
    "expired_timestamp" TIMESTAMP(6),
    "current" BOOLEAN,

    CONSTRAINT "system_info_revision_pkey" PRIMARY KEY ("id","revision_id")
);

-- CreateTable
CREATE TABLE "tag" (
    "id" TEXT NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "vocabulary_id" VARCHAR(100),

    CONSTRAINT "tag_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "task_status" (
    "id" TEXT NOT NULL,
    "entity_id" TEXT NOT NULL,
    "entity_type" TEXT NOT NULL,
    "task_type" TEXT NOT NULL,
    "key" TEXT NOT NULL,
    "value" TEXT NOT NULL,
    "state" TEXT,
    "error" TEXT,
    "last_updated" TIMESTAMP(6),

    CONSTRAINT "task_status_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "term_translation" (
    "term" TEXT NOT NULL,
    "term_translation" TEXT NOT NULL,
    "lang_code" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "tracking_raw" (
    "user_key" VARCHAR(100) NOT NULL,
    "url" TEXT NOT NULL,
    "tracking_type" VARCHAR(10) NOT NULL,
    "access_timestamp" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "tracking_summary" (
    "url" TEXT NOT NULL,
    "package_id" TEXT,
    "tracking_type" VARCHAR(10) NOT NULL,
    "count" INTEGER NOT NULL,
    "running_total" INTEGER NOT NULL DEFAULT 0,
    "recent_views" INTEGER NOT NULL DEFAULT 0,
    "tracking_date" DATE
);

-- CreateTable
CREATE TABLE "user" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "apikey" TEXT,
    "created" TIMESTAMP(6),
    "about" TEXT,
    "password" TEXT,
    "fullname" TEXT,
    "email" TEXT,
    "reset_key" TEXT,
    "sysadmin" BOOLEAN DEFAULT false,
    "activity_streams_email_notifications" BOOLEAN DEFAULT false,
    "state" TEXT NOT NULL DEFAULT 'active',
    "plugin_extras" JSONB,
    "image_url" TEXT,

    CONSTRAINT "user_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user_following_dataset" (
    "follower_id" TEXT NOT NULL,
    "object_id" TEXT NOT NULL,
    "datetime" TIMESTAMP(6) NOT NULL,

    CONSTRAINT "user_following_dataset_pkey" PRIMARY KEY ("follower_id","object_id")
);

-- CreateTable
CREATE TABLE "user_following_group" (
    "follower_id" TEXT NOT NULL,
    "object_id" TEXT NOT NULL,
    "datetime" TIMESTAMP(6) NOT NULL,

    CONSTRAINT "user_following_group_pkey" PRIMARY KEY ("follower_id","object_id")
);

-- CreateTable
CREATE TABLE "user_following_user" (
    "follower_id" TEXT NOT NULL,
    "object_id" TEXT NOT NULL,
    "datetime" TIMESTAMP(6) NOT NULL,

    CONSTRAINT "user_following_user_pkey" PRIMARY KEY ("follower_id","object_id")
);

-- CreateTable
CREATE TABLE "vocabulary" (
    "id" TEXT NOT NULL,
    "name" VARCHAR(100) NOT NULL,

    CONSTRAINT "vocabulary_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "zemantic_user" (
    "id" BIGSERIAL NOT NULL,
    "mobile" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "userId" TEXT NOT NULL,

    CONSTRAINT "zemantic_user_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "zemantic_submission" (
    "id" BIGSERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "userId" TEXT NOT NULL,

    CONSTRAINT "zemantic_submission_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "zemantic_tag" (
    "id" BIGSERIAL NOT NULL,
    "tag" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "zemantic_tag_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "zemantic_submission_file" (
    "id" BIGSERIAL NOT NULL,
    "file_name" TEXT NOT NULL,
    "file_type" TEXT NOT NULL,
    "file_size" DECIMAL(65,30) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "zemantic_submissionId" BIGINT NOT NULL,

    CONSTRAINT "zemantic_submission_file_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "zemantic_setting" (
    "id" BIGSERIAL NOT NULL,
    "key" TEXT NOT NULL,
    "value" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "zemantic_setting_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "idx_activity_object_id" ON "activity"("object_id", "timestamp");

-- CreateIndex
CREATE INDEX "idx_activity_user_id" ON "activity"("user_id", "timestamp");

-- CreateIndex
CREATE INDEX "idx_activity_detail_activity_id" ON "activity_detail"("activity_id");

-- CreateIndex
CREATE UNIQUE INDEX "group_name_key" ON "group"("name");

-- CreateIndex
CREATE INDEX "idx_group_id" ON "group"("id");

-- CreateIndex
CREATE INDEX "idx_group_name" ON "group"("name");

-- CreateIndex
CREATE INDEX "idx_group_extra_group_id" ON "group_extra"("group_id");

-- CreateIndex
CREATE INDEX "idx_group_extra_current" ON "group_extra_revision"("current");

-- CreateIndex
CREATE INDEX "idx_group_extra_period" ON "group_extra_revision"("revision_timestamp", "expired_timestamp", "id");

-- CreateIndex
CREATE INDEX "idx_group_extra_period_group" ON "group_extra_revision"("revision_timestamp", "expired_timestamp", "group_id");

-- CreateIndex
CREATE INDEX "idx_group_current" ON "group_revision"("current");

-- CreateIndex
CREATE INDEX "idx_group_period" ON "group_revision"("revision_timestamp", "expired_timestamp", "id");

-- CreateIndex
CREATE INDEX "idx_extra_grp_id_pkg_id" ON "member"("group_id", "table_id");

-- CreateIndex
CREATE INDEX "idx_group_pkg_id" ON "member"("table_id");

-- CreateIndex
CREATE INDEX "idx_package_group_group_id" ON "member"("group_id");

-- CreateIndex
CREATE INDEX "idx_package_group_id" ON "member"("id");

-- CreateIndex
CREATE INDEX "idx_package_group_pkg_id" ON "member"("table_id");

-- CreateIndex
CREATE INDEX "idx_package_group_pkg_id_group_id" ON "member"("group_id", "table_id");

-- CreateIndex
CREATE INDEX "idx_member_continuity_id" ON "member_revision"("continuity_id");

-- CreateIndex
CREATE INDEX "idx_package_group_current" ON "member_revision"("current");

-- CreateIndex
CREATE INDEX "idx_package_group_period_package_group" ON "member_revision"("revision_timestamp", "expired_timestamp", "table_id", "group_id");

-- CreateIndex
CREATE UNIQUE INDEX "package_name_key" ON "package"("name");

-- CreateIndex
CREATE INDEX "idx_package_creator_user_id" ON "package"("creator_user_id");

-- CreateIndex
CREATE INDEX "idx_pkg_id" ON "package"("id");

-- CreateIndex
CREATE INDEX "idx_pkg_name" ON "package"("name");

-- CreateIndex
CREATE INDEX "idx_pkg_sid" ON "package"("id", "state");

-- CreateIndex
CREATE INDEX "idx_pkg_sname" ON "package"("name", "state");

-- CreateIndex
CREATE INDEX "idx_pkg_stitle" ON "package"("title", "state");

-- CreateIndex
CREATE INDEX "idx_pkg_title" ON "package"("title");

-- CreateIndex
CREATE INDEX "idx_extra_id_pkg_id" ON "package_extra"("id", "package_id");

-- CreateIndex
CREATE INDEX "idx_extra_pkg_id" ON "package_extra"("package_id");

-- CreateIndex
CREATE INDEX "idx_package_extra_continuity_id" ON "package_extra_revision"("continuity_id");

-- CreateIndex
CREATE INDEX "idx_package_extra_current" ON "package_extra_revision"("current");

-- CreateIndex
CREATE INDEX "idx_package_extra_package_id" ON "package_extra_revision"("package_id", "current");

-- CreateIndex
CREATE INDEX "idx_package_extra_period" ON "package_extra_revision"("revision_timestamp", "expired_timestamp", "id");

-- CreateIndex
CREATE INDEX "idx_package_extra_period_package" ON "package_extra_revision"("revision_timestamp", "expired_timestamp", "package_id");

-- CreateIndex
CREATE INDEX "idx_package_extra_rev_id" ON "package_extra_revision"("revision_id");

-- CreateIndex
CREATE INDEX "idx_package_relationship_current" ON "package_relationship_revision"("current");

-- CreateIndex
CREATE INDEX "idx_period_package_relationship" ON "package_relationship_revision"("revision_timestamp", "expired_timestamp", "object_package_id", "subject_package_id");

-- CreateIndex
CREATE INDEX "idx_package_continuity_id" ON "package_revision"("continuity_id");

-- CreateIndex
CREATE INDEX "idx_package_current" ON "package_revision"("current");

-- CreateIndex
CREATE INDEX "idx_package_period" ON "package_revision"("revision_timestamp", "expired_timestamp", "id");

-- CreateIndex
CREATE INDEX "idx_pkg_revision_id" ON "package_revision"("id");

-- CreateIndex
CREATE INDEX "idx_pkg_revision_name" ON "package_revision"("name");

-- CreateIndex
CREATE INDEX "idx_pkg_revision_rev_id" ON "package_revision"("revision_id");

-- CreateIndex
CREATE INDEX "idx_package_tag_id" ON "package_tag"("id");

-- CreateIndex
CREATE INDEX "idx_package_tag_pkg_id" ON "package_tag"("package_id");

-- CreateIndex
CREATE INDEX "idx_package_tag_pkg_id_tag_id" ON "package_tag"("tag_id", "package_id");

-- CreateIndex
CREATE INDEX "idx_package_tag_tag_id" ON "package_tag"("tag_id");

-- CreateIndex
CREATE INDEX "idx_package_tag_continuity_id" ON "package_tag_revision"("continuity_id");

-- CreateIndex
CREATE INDEX "idx_package_tag_current" ON "package_tag_revision"("current");

-- CreateIndex
CREATE INDEX "idx_package_tag_revision_id" ON "package_tag_revision"("id");

-- CreateIndex
CREATE INDEX "idx_package_tag_revision_pkg_id" ON "package_tag_revision"("package_id");

-- CreateIndex
CREATE INDEX "idx_package_tag_revision_pkg_id_tag_id" ON "package_tag_revision"("tag_id", "package_id");

-- CreateIndex
CREATE INDEX "idx_package_tag_revision_rev_id" ON "package_tag_revision"("revision_id");

-- CreateIndex
CREATE INDEX "idx_package_tag_revision_tag_id" ON "package_tag_revision"("tag_id");

-- CreateIndex
CREATE INDEX "idx_period_package_tag" ON "package_tag_revision"("revision_timestamp", "expired_timestamp", "package_id", "tag_id");

-- CreateIndex
CREATE INDEX "idx_rating_id" ON "rating"("id");

-- CreateIndex
CREATE INDEX "idx_rating_package_id" ON "rating"("package_id");

-- CreateIndex
CREATE INDEX "idx_rating_user_id" ON "rating"("user_id");

-- CreateIndex
CREATE INDEX "idx_package_resource_id" ON "resource"("id");

-- CreateIndex
CREATE INDEX "idx_package_resource_package_id" ON "resource"("package_id");

-- CreateIndex
CREATE INDEX "idx_package_resource_url" ON "resource"("url");

-- CreateIndex
CREATE INDEX "idx_package_resource_rev_id" ON "resource_revision"("revision_id");

-- CreateIndex
CREATE INDEX "idx_resource_continuity_id" ON "resource_revision"("continuity_id");

-- CreateIndex
CREATE INDEX "idx_resource_current" ON "resource_revision"("current");

-- CreateIndex
CREATE INDEX "idx_resource_period" ON "resource_revision"("revision_timestamp", "expired_timestamp", "id");

-- CreateIndex
CREATE INDEX "idx_rev_state" ON "revision"("state");

-- CreateIndex
CREATE INDEX "idx_revision_author" ON "revision"("author");

-- CreateIndex
CREATE UNIQUE INDEX "system_info_key_key" ON "system_info"("key");

-- CreateIndex
CREATE INDEX "idx_tag_id" ON "tag"("id");

-- CreateIndex
CREATE INDEX "idx_tag_name" ON "tag"("name");

-- CreateIndex
CREATE UNIQUE INDEX "tag_name_vocabulary_id_key" ON "tag"("name", "vocabulary_id");

-- CreateIndex
CREATE UNIQUE INDEX "task_status_entity_id_task_type_key_key" ON "task_status"("entity_id", "task_type", "key");

-- CreateIndex
CREATE INDEX "term" ON "term_translation"("term");

-- CreateIndex
CREATE INDEX "term_lang" ON "term_translation"("term", "lang_code");

-- CreateIndex
CREATE INDEX "tracking_raw_access_timestamp" ON "tracking_raw"("access_timestamp");

-- CreateIndex
CREATE INDEX "tracking_raw_url" ON "tracking_raw"("url");

-- CreateIndex
CREATE INDEX "tracking_raw_user_key" ON "tracking_raw"("user_key");

-- CreateIndex
CREATE INDEX "tracking_summary_date" ON "tracking_summary"("tracking_date");

-- CreateIndex
CREATE INDEX "tracking_summary_package_id" ON "tracking_summary"("package_id");

-- CreateIndex
CREATE INDEX "tracking_summary_url" ON "tracking_summary"("url");

-- CreateIndex
CREATE UNIQUE INDEX "user_name_key" ON "user"("name");

-- CreateIndex
CREATE INDEX "idx_user_id" ON "user"("id");

-- CreateIndex
CREATE INDEX "idx_user_name" ON "user"("name");

-- CreateIndex
CREATE UNIQUE INDEX "vocabulary_name_key" ON "vocabulary"("name");

-- CreateIndex
CREATE UNIQUE INDEX "zemantic_setting_key_key" ON "zemantic_setting"("key");

-- AddForeignKey
ALTER TABLE "activity_detail" ADD CONSTRAINT "activity_detail_activity_id_fkey" FOREIGN KEY ("activity_id") REFERENCES "activity"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "api_token" ADD CONSTRAINT "api_token_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "dashboard" ADD CONSTRAINT "dashboard_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "user"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "group_extra" ADD CONSTRAINT "group_extra_group_id_fkey" FOREIGN KEY ("group_id") REFERENCES "group"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "group_extra_revision" ADD CONSTRAINT "group_extra_revision_group_id_fkey" FOREIGN KEY ("group_id") REFERENCES "group"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "group_extra_revision" ADD CONSTRAINT "group_extra_revision_revision_id_fkey" FOREIGN KEY ("revision_id") REFERENCES "revision"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "group_revision" ADD CONSTRAINT "group_revision_revision_id_fkey" FOREIGN KEY ("revision_id") REFERENCES "revision"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "member" ADD CONSTRAINT "member_group_id_fkey" FOREIGN KEY ("group_id") REFERENCES "group"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "member_revision" ADD CONSTRAINT "member_revision_revision_id_fkey" FOREIGN KEY ("revision_id") REFERENCES "revision"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "package_extra" ADD CONSTRAINT "package_extra_package_id_fkey" FOREIGN KEY ("package_id") REFERENCES "package"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "package_extra_revision" ADD CONSTRAINT "package_extra_revision_revision_id_fkey" FOREIGN KEY ("revision_id") REFERENCES "revision"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "package_member" ADD CONSTRAINT "package_member_package_id_fkey" FOREIGN KEY ("package_id") REFERENCES "package"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "package_member" ADD CONSTRAINT "package_member_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "package_relationship" ADD CONSTRAINT "package_relationship_object_package_id_fkey" FOREIGN KEY ("object_package_id") REFERENCES "package"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "package_relationship" ADD CONSTRAINT "package_relationship_subject_package_id_fkey" FOREIGN KEY ("subject_package_id") REFERENCES "package"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "package_relationship_revision" ADD CONSTRAINT "package_relationship_revision_continuity_id_fkey" FOREIGN KEY ("continuity_id") REFERENCES "package_relationship"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "package_relationship_revision" ADD CONSTRAINT "package_relationship_revision_object_package_id_fkey" FOREIGN KEY ("object_package_id") REFERENCES "package"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "package_relationship_revision" ADD CONSTRAINT "package_relationship_revision_revision_id_fkey" FOREIGN KEY ("revision_id") REFERENCES "revision"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "package_relationship_revision" ADD CONSTRAINT "package_relationship_revision_subject_package_id_fkey" FOREIGN KEY ("subject_package_id") REFERENCES "package"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "package_revision" ADD CONSTRAINT "package_revision_revision_id_fkey" FOREIGN KEY ("revision_id") REFERENCES "revision"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "package_tag" ADD CONSTRAINT "package_tag_package_id_fkey" FOREIGN KEY ("package_id") REFERENCES "package"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "package_tag" ADD CONSTRAINT "package_tag_tag_id_fkey" FOREIGN KEY ("tag_id") REFERENCES "tag"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "package_tag_revision" ADD CONSTRAINT "package_tag_revision_revision_id_fkey" FOREIGN KEY ("revision_id") REFERENCES "revision"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "package_tag_revision" ADD CONSTRAINT "package_tag_revision_tag_id_fkey" FOREIGN KEY ("tag_id") REFERENCES "tag"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "rating" ADD CONSTRAINT "rating_package_id_fkey" FOREIGN KEY ("package_id") REFERENCES "package"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "rating" ADD CONSTRAINT "rating_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "resource_revision" ADD CONSTRAINT "resource_revision_revision_id_fkey" FOREIGN KEY ("revision_id") REFERENCES "revision"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "resource_view" ADD CONSTRAINT "resource_view_resource_id_fkey" FOREIGN KEY ("resource_id") REFERENCES "resource"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "system_info_revision" ADD CONSTRAINT "system_info_revision_continuity_id_fkey" FOREIGN KEY ("continuity_id") REFERENCES "system_info"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "system_info_revision" ADD CONSTRAINT "system_info_revision_revision_id_fkey" FOREIGN KEY ("revision_id") REFERENCES "revision"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tag" ADD CONSTRAINT "tag_vocabulary_id_fkey" FOREIGN KEY ("vocabulary_id") REFERENCES "vocabulary"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "user_following_dataset" ADD CONSTRAINT "user_following_dataset_follower_id_fkey" FOREIGN KEY ("follower_id") REFERENCES "user"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_following_dataset" ADD CONSTRAINT "user_following_dataset_object_id_fkey" FOREIGN KEY ("object_id") REFERENCES "package"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_following_group" ADD CONSTRAINT "user_following_group_group_id_fkey" FOREIGN KEY ("object_id") REFERENCES "group"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_following_group" ADD CONSTRAINT "user_following_group_user_id_fkey" FOREIGN KEY ("follower_id") REFERENCES "user"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_following_user" ADD CONSTRAINT "user_following_user_follower_id_fkey" FOREIGN KEY ("follower_id") REFERENCES "user"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_following_user" ADD CONSTRAINT "user_following_user_object_id_fkey" FOREIGN KEY ("object_id") REFERENCES "user"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "zemantic_user" ADD CONSTRAINT "zemantic_user_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "zemantic_submission" ADD CONSTRAINT "zemantic_submission_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "zemantic_submission_file" ADD CONSTRAINT "zemantic_submission_file_zemantic_submissionId_fkey" FOREIGN KEY ("zemantic_submissionId") REFERENCES "zemantic_submission"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
