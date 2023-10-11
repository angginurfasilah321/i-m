CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE TABLE "Location" (
  "uuid" uuid DEFAULT uuid_generate_v4() UNIQUE PRIMARY KEY,
  "name" varchar,
  "address" varchar,
  "created_at" timestamptz NOT NULL DEFAULT (now())
);

CREATE TABLE "Category" (
  "uuid" uuid DEFAULT uuid_generate_v4() UNIQUE PRIMARY KEY,
  "name" varchar,
  "created_at" timestamptz NOT NULL DEFAULT (now())
);

CREATE TABLE "Tenant" (
  "uuid" uuid DEFAULT uuid_generate_v4() UNIQUE PRIMARY KEY,
  "location_uuid" uuid,
  "category_uuid" uuid,
  "name" varchar,
  "area_size" decimal,
  "bottom_rate_per_month" decimal,
  "revenue_sharing_percentage" decimal,
  "created_at" timestamptz NOT NULL DEFAULT (now())
);

CREATE TABLE "Sales_Data" (
  "uuid" uuid DEFAULT uuid_generate_v4() UNIQUE PRIMARY KEY,
  "tenant_uuid" uuid,
  "date" date,
  "projected_revenue" decimal,
  "actual_revenue" decimal,
  "budget_revenue" decimal,
  "revenue_sharing_amount" decimal,
  "created_at" timestamptz NOT NULL DEFAULT (now())
);

CREATE TABLE "Revenue_Sharing" (
  "uuid" uuid DEFAULT uuid_generate_v4() UNIQUE PRIMARY KEY,
  "tenant_uuid" uuid,
  "period_start" date,
  "period_end" date,
  "revenue_sharing_percentage" decimal,
  "total_revenue" decimal,
  "total_revenue_sharing" decimal,
  "remarks" varchar,
  "created_at" timestamptz NOT NULL DEFAULT (now())
);

CREATE TABLE "Comparative_Analysis" (
  "uuid" uuid DEFAULT uuid_generate_v4() UNIQUE PRIMARY KEY,
  "tenant_uuid" uuid,
  "date" date,
  "projected_vs_actual_revenue" decimal,
  "budget_vs_actual_revenue_sharing" decimal,
  "bottom_rate_vs_actual_revenue_sharing" decimal,
  "created_at" timestamptz NOT NULL DEFAULT (now())
);

CREATE TABLE "Performance_Metrics" (
  "uuid" uuid DEFAULT uuid_generate_v4() UNIQUE PRIMARY KEY,
  "tenant_uuid" uuid,
  "date" date,
  "performance_percentage_for_revenue" decimal,
  "performance_percentage_for_revenue_sharing" decimal,
  "created_at" timestamptz NOT NULL DEFAULT (now())
);

-- Creating unique indexes
CREATE INDEX "idx_location_uuid" ON "Tenant" ("location_uuid");
CREATE INDEX "idx_category_uuid" ON "Tenant" ("category_uuid");
CREATE INDEX "idx_tenant_uuid_sales_data" ON "Sales_Data" ("tenant_uuid");
CREATE INDEX "idx_tenant_uuid_revenue_sharing" ON "Revenue_Sharing" ("tenant_uuid");
CREATE INDEX "idx_tenant_uuid_comparative_analysis" ON "Comparative_Analysis" ("tenant_uuid");
CREATE INDEX "idx_tenant_uuid_performance_metrics" ON "Performance_Metrics" ("tenant_uuid");

-- Adding comments to columns
COMMENT ON COLUMN "Location"."uuid" IS 'Primary Key';
COMMENT ON COLUMN "Category"."uuid" IS 'Primary Key';
COMMENT ON COLUMN "Tenant"."uuid" IS 'Primary Key';
COMMENT ON COLUMN "Tenant"."location_uuid" IS 'Foreign Key';
COMMENT ON COLUMN "Tenant"."category_uuid" IS 'Foreign Key, Nullable';
COMMENT ON COLUMN "Sales_Data"."uuid" IS 'Primary Key';
COMMENT ON COLUMN "Sales_Data"."tenant_uuid" IS 'Foreign Key';
COMMENT ON COLUMN "Revenue_Sharing"."uuid" IS 'Primary Key';
COMMENT ON COLUMN "Revenue_Sharing"."tenant_uuid" IS 'Foreign Key';
COMMENT ON COLUMN "Comparative_Analysis"."uuid" IS 'Primary Key';
COMMENT ON COLUMN "Comparative_Analysis"."tenant_uuid" IS 'Foreign Key';
COMMENT ON COLUMN "Performance_Metrics"."uuid" IS 'Primary Key';
COMMENT ON COLUMN "Performance_Metrics"."tenant_uuid" IS 'Foreign Key';

-- Defining foreign key constraints
ALTER TABLE "Tenant" ADD FOREIGN KEY ("location_uuid") REFERENCES "Location" ("uuid");
ALTER TABLE "Tenant" ADD FOREIGN KEY ("category_uuid") REFERENCES "Category" ("uuid");
ALTER TABLE "Sales_Data" ADD FOREIGN KEY ("tenant_uuid") REFERENCES "Tenant" ("uuid");
ALTER TABLE "Revenue_Sharing" ADD FOREIGN KEY ("tenant_uuid") REFERENCES "Tenant" ("uuid");
ALTER TABLE "Comparative_Analysis" ADD FOREIGN KEY ("tenant_uuid") REFERENCES "Tenant" ("uuid");
ALTER TABLE "Performance_Metrics" ADD FOREIGN KEY ("tenant_uuid") REFERENCES "Tenant" ("uuid");
